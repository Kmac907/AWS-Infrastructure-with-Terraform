resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Change to a suitable AMI for your region
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y python3 postgresql python3-pip
    pip3 install flask psycopg2-binary

    # Create the application directory
    mkdir -p /home/ec2-user/app

    # Create a simple Flask application
    cat << 'EOF2' > /home/ec2-user/app/app.py
    from flask import Flask, request, jsonify
    import psycopg2
    import os

    app = Flask(__name__)

    DB_HOST = os.getenv("DB_HOST")
    DB_NAME = os.getenv("DB_NAME")
    DB_USER = os.getenv("DB_USER")
    DB_PASS = os.getenv("DB_PASS")

    conn = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )
    cursor = conn.cursor()

    @app.route('/')
    def index():
        return "Hello, World!"

    @app.route('/submit', methods=['POST'])
    def submit():
        data = request.json
        name = data.get('name')
        query = "INSERT INTO users (name) VALUES (%s);"
        cursor.execute(query, (name,))
        conn.commit()
        return jsonify({"message": "Data inserted successfully!"})

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=80)

    EOF2

    # Create a systemd service file for the Flask app
    cat << 'EOF2' > /etc/systemd/system/flaskapp.service
    [Unit]
    Description=Flask App

    [Service]
    ExecStart=/usr/bin/python3 /home/ec2-user/app/app.py
    WorkingDirectory=/home/ec2-user/app
    Environment="DB_HOST=${DB_HOST}"
    Environment="DB_NAME=exampledb"
    Environment="DB_USER=foo"
    Environment="DB_PASS=bar12345"
    Restart=always
    User=ec2-user

    [Install]
    WantedBy=multi-user.target

    EOF2

    # Reload systemd, enable and start the Flask app service
    sudo systemctl daemon-reload
    sudo systemctl enable flaskapp
    sudo systemctl start flaskapp

  EOF

  tags = {
    Name = "web_instance"
  }
}
