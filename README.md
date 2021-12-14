# Trentonianna-Redesign
Jabili Gadde, 
Lakaylah Gage, 
Nicole Kercado, 
Anthony Scarpa, 
Claire Segal

# Trentoniana Redesign Project

CSC315 & HON270


## Project Description:

The objective of this project was to redesign both the database of interview recordings associated with the Trentoniana website as well as the site itself. At the time the project was assigned, the Trentoniana site and database were extremely dated and not efficient to work with. The project is a combination of our own PostgreSQL database combined with an HTML and CSS front end, connected together using Python-based Flask. The project combines better filtering, a more approachable interface, and ease of data access to provide an objectively better browsing experience than the one currently implemented on Trentoniana.

## Installation Instructions:

Download PostgreSQL: https://www.postgresql.org/download/

Download CSC315CAB
Download UpdatedStageVPopulate.sql
Download UpdatedStage5DropFile.sql
Install Flask: Instructions located in the app.py file within the CSC315CAB folder

## How to Run:

Run the UpdatedStageVPopulate.sql file in the PostgreSQL database by entering the following command: \i UpdatedStageVPopulate.sql (NOTE: the file must be in the same directory as the database). This will create the schema and populate all of the tables.
Modify the database.ini file in the CSC315CAB folder to match the information of your database.
To launch the website, go to the CSC315CAB directory in the terminal and enter the following command: export FLASK_APP=app.py && flask run
This should produce a link. If you click on the link, you will launch the website.
If you ever want to reset everything in the database, run the UpdatedStage5DropFile.sql file by entering the following command: \i UpdatedStage5DropFile.sql. Then create the schema and populate the database again by entering the following command: \i UpdatedStageVPopulate.sql.

## How to Use Our Website:

Upon launching the site, you will be taken to the home page. On this page, you can search by recording title or filter by various categories in order to filter the recordings. You can also select a recording, in which case you will be taken to a different page where you can view a description of the recording, its publication date, the decade it was recorded in, and the topics associated with that recording. You can also access a link to the audio file for the recording as well as to the transcript. 

There is also a link on the home page that will take you to a superuser login page. Superusers can login to access superuser functionality here. The sample superuser username and password that is contained in the database is Username123 and Password123. If you enter those values, you will be able to access the Superuser page. Once on the Superuser page, you can view all of the recording attributes, speaker attributes, and transcript attributes related to a recording by entering the recording title in the first form on the page. You can also perform various other actions, such as adding, deleting, and updating a recording, speaker, transcript, and/or topics relating to a recording. You can also add and delete superusers.

## License:

[Click Here](https://github.com/nicolekercado/Trentonianna-Redesign/blob/main/OpenSourceLicense)
