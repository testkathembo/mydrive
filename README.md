# mydrive

This Django project is configured to use a MySQL database. To ensure smooth operation, please follow these instructions carefully:

Prerequisites
XAMPP Installation: Ensure that XAMPP is installed on your PC. 

Database Setup
The project uses a MySQL database named mydrive. You must create this database within your MySQL instance to connect the Django application to it.

Steps to Setup and Run the Project
- Start XAMPP: Launch the XAMPP control panel and start the Apache and MySQL modules. 
- Create the Database: Open your browser and go to http://localhost/phpmyadmin to access the phpMyAdmin interface.
Create a new database named mydrive. Ensure the collation is set to utf8_general_ci to support UTF-8 encoding.
- Import the Database: If you have a .sql file to import, navigate to the "Import" tab in phpMyAdmin while you have the mydrive database selected.
Choose the .sql file from your local system that contains the necessary database structure and data.
Click on the "Go" button at the bottom of the page to import the database. Ensure that the import completes without errors.
Configure Django:

- Open the Django project’s settings file, usually found at mycloud_drive/settings.py.
Confirm that the database settings are correctly set to connect to your MySQL instance:

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mydrive',
        'USER': 'root',  # Default XAMPP MySQL user, adjust if you have a different user
        'PASSWORD': '',  # Default XAMPP MySQL password is empty, set your password if you have changed it
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
If you have changed the default username or password of your MySQL database, update these values accordingly.
Run Migrations (if necessary):

Open a command prompt or terminal in the project directory.
Activate your virtual environment if you are using one.
Execute the following commands to make sure your database is ready to be used with Django:
God to your Terminal and type the following code:
python manage.py makemigrations
python manage.py migrate

Start the Django Development Server:

In the terminal, run:
python manage.py runserver
This will start the development server, and you should see output indicating it is running. By default, it runs at http://127.0.0.1:8000/.
