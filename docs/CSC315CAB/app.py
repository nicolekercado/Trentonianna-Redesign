#! /usr/bin/python3

"""
ONE-TIME SETUP

To run this example in the CSC 315 VM you first need to make
the following one-time configuration changes:

# set the postgreSQL password for user 'lion'
sudo -u postgres psql
    ALTER USER lion PASSWORD 'lion';
    \q

# install pip for Python 3
sudo apt update
sudo apt install python3-pip

# install psycopg2
pip3 install psycopg2-binary

# install flask
pip3 install flask

# logout, then login again to inherit new shell environment
"""

"""
CSC 315
Spring 2021
John DeGood

# usage
export FLASK_APP=app.py 
flask run

# then browse to http://127.0.0.1:5000/

Purpose:
Demonstrate Flask/Python to PostgreSQL using the psycopg adapter.
Connects to the 7dbs database from "Seven Databases in Seven Days"
in the CSC 315 VM.

For psycopg documentation:
https://www.psycopg.org/

This example code is derived from:
https://www.postgresqltutorial.com/postgresql-python/
https://scoutapm.com/blog/python-flask-tutorial-getting-started-with-flask
https://www.geeksforgeeks.org/python-using-for-loop-in-flask/
"""
import psycopg2
from config import config
from flask import Flask, render_template, request
import datetime

#Connect function for queries, based on example given to us
def connect(query):
    """ Connect to the PostgreSQL database server """
    conn = None
    rows = []
    try:
        # read connection parameters from database.ini
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the %s database...' % (params['database']))
        conn = psycopg2.connect(**params)
        print('Connected.')
      
        # create a cursor
        cur = conn.cursor()
        
        # execute query
        cur.execute(query)
        rows = cur.fetchall()

       # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
    # return the query result from fetchall()
    return rows

#Connect function for insertions -- Implemented by Jabili
def connect2(query):
    """ Connect to the PostgreSQL database server """
    conn = None
    rows = []
    key = ""
    try:
        # read connection parameters from database.ini
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the %s database...' % (params['database']))
        conn = psycopg2.connect(**params)
        print('Connected.')
      
        # create a cursor
        cur = conn.cursor()
        
        # execute query
        cur.execute(query)

        #returning value
        key = cur.fetchone()[0]

        #commit changes
        conn.commit()   

       # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
    # return the query result from fetchall()
    return key

#Connect Function for Deletions -- Implemented by Jabili
def connect3(query):
    """ Connect to the PostgreSQL database server """
    conn = None
    rows = []
    rows_deleted = 0
    try:
        # read connection parameters from database.ini
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the %s database...' % (params['database']))
        conn = psycopg2.connect(**params)
        print('Connected.')
      
        # create a cursor
        cur = conn.cursor()
        
        # execute query
        cur.execute(query)

        rows_deleted = cur.rowcount

        conn.commit()

       # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
    # return the query result from fetchall()
    return rows_deleted

#Connect Function for Updates -- Implemented by Lakaylah
def connect4(query):
    """ Connect to the PostgreSQL database server """
    conn = None
    rows = []
    key = ""
    try:
        # read connection parameters from database.ini
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the %s database...' % (params['database']))
        conn = psycopg2.connect(**params)
        print('Connected.')
      
        # create a cursor
        cur = conn.cursor()
        
        # execute query
        cur.execute(query)

        key = cur.rowcount

        conn.commit()

       # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
    # return the query result from fetchall()
    return key

# app.py

app = Flask(__name__)


#home page -- Implemented by Jabili
@app.route("/")
def form():
    #display all recordings by default
    query = "SELECT Recording_title FROM RECORDING;"
    rows = connect(query)
    return render_template('index.html', rows=rows)

# When routed to this, display the superuserlogin page -- Implemented by Jabili
@app.route("/superuserlogin/")
def superuserlogin():
    return render_template('superuserlogin.html')

# When routed to this, display the superuser page -- Implemented by Jabili
@app.route("/superuser/")
def superuser():
    return render_template('superuser.html')

# Function for searching recordings by recording title
# Connected to the search recording form
# Implemented on a group zoom call with all 4 of us, but primarily by Jabili
@app.route('/search-recording', methods=['POST'])
def handle_data():
    query = "SELECT Recording_title FROM RECORDING WHERE Recording_title % '" + request.form['searchRecording'] + "';"
    rows = connect(query)

    return render_template('index.html', rows=rows)

# Function for filtering recordings 
# Implemented on a group zoom call, but primarily by Jabili
# Debugged by all
@app.route('/filter-recording', methods=['POST'])
def filter():
    #request.form.get will return none if no input, whereas request.form will throw an error
    #these fields are optional, so use request.form.get
    
    #Only if the user checked off that year, run the query getting the resulting recordings
    #Then put the results together for every year that was checked off
    years = []
    yearSel = False
    year1 = request.form.get('year1')
    if year1 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year1 + ";"
        years = connect(query)
        yearSel = True
    year2 = request.form.get('year2')
    if year2 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year2 + ";"
        years = years + connect(query)
        yearSel = True
    year3 = request.form.get('year3')
    if year3 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year3 + ";"
        years = years + connect(query)
        yearSel = True
    year4 = request.form.get('year4')
    if year4 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year4 + ";"
        years = years + connect(query)
        yearSel = True
    year5 = request.form.get('year5')
    if year5 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year5 + ";"
        years = years + connect(query)
        yearSel = True
    year6 = request.form.get('year6')
    if year6 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year6 + ";"
        years = years + connect(query)
        yearSel = True
    year7 = request.form.get('year7')
    if year7 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year7 + ";"
        years = years + connect(query)
        yearSel = True
    year8 = request.form.get('year8')
    if year8 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year8 + ";"
        years = years + connect(query)
        yearSel = True
    year9 = request.form.get('year9')
    if year9 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year9 + ";"
        years = years + connect(query)
        yearSel = True
    year10 = request.form.get('year10')
    if year10 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year10 + ";"
        years = years + connect(query)
        yearSel = True
    year11 = request.form.get('year11')
    if year11 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year11 + ";"
        years = years + connect(query)
        yearSel = True
    year12 = request.form.get('year12')
    if year12 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year12 + ";"
        years = years + connect(query)
        yearSel = True
    year13 = request.form.get('year13')
    if year13 != None:
        query = "SELECT Recording_title FROM RECORDING WHERE Year_recorded = " + year13 + ";"
        years = years + connect(query)
        yearSel = True

    # Example query for filtering by topic:    
    # SELECT Recording_title
    # FROM RECORDING_TOPIC
    # WHERE Topic_or_category_name = 'World War II' OR Topic_or_category_name = 'Education';
    
    #Only if the user checked off that topic, run the query getting the resulting recordings
    #Then do a union on all of the results of the topics that were checked off
    #in order to put them together and prevent duplicates
    topics = []
    topicSel = False
    topic1 = request.form.get('topic1')
    if topic1 != None:
        query = "SELECT Recording_title FROM RECORDING_TOPIC WHERE Topic_or_category_name = '" + topic1 + "';"
        print(query)
        topics = connect(query)
        topicSel = True
        
    topic2 = request.form.get('topic2')
    if topic2 != None:
        query = "SELECT Recording_title FROM RECORDING_TOPIC WHERE Topic_or_category_name = '" + topic2 + "';"
        topics = list(set(topics).union(set(connect(query))))
        topicSel = True
        
    topic3 = request.form.get('topic3')
    if topic3 != None:
        query = "SELECT Recording_title FROM RECORDING_TOPIC WHERE Topic_or_category_name = '" + topic3 + "';"
        topics = list(set(topics).union(set(connect(query))))
        topicSel = True

    topic4 = request.form.get('topic4')
    if topic4 != None:
        query = "SELECT Recording_title FROM RECORDING_TOPIC WHERE Topic_or_category_name = '" + topic4 + "';"
        topics = list(set(topics).union(set(connect(query))))
        topicSel = True

    topic5 = request.form.get('topic5')
    if topic5 != None:
        query = "SELECT Recording_title FROM RECORDING_TOPIC WHERE Topic_or_category_name = '" + topic5 + "';"
        topics = list(set(topics).union(set(connect(query))))
        topicSel = True

    topic6 = request.form.get('topic6')
    if topic6 != None:
        query = "SELECT Recording_title FROM RECORDING_TOPIC WHERE Topic_or_category_name = '" + topic6 + "';"
        topics = list(set(topics).union(set(connect(query))))
        topicSel = True
    
    #Example query for querying by Nationality
    '''
    SELECT Recording_title
    FROM RECORDING_SPEAKER
    WHERE Nationality = 'Polish';
    '''

    #If the nationality was checked off, run the query and get the result
    nationality = []
    nationalitySel = False
    nationality1 = request.form.get('nationality1')
    if nationality1 != None:
        query = "SELECT Recording_title FROM RECORDING_SPEAKER WHERE Nationality = '" + nationality1 + "';"
        nationality = connect(query)
        nationalitySel = True
    
    #Example query for filtering by whether or not a speaker is jewish
    '''
    SELECT Recording_title
    FROM RECORDING_SPEAKER
    WHERE Is_jewish = TRUE;
    '''

    #If an option was selected, run the according query and store the result
    jewish = []
    jewishSel = False
    jew = request.form.get('jewish')
    if jew != None:
        query = "SELECT Recording_title FROM RECORDING_SPEAKER WHERE Is_jewish = " + jew + ";"
        jewish = connect(query)
        jewishSel = True

    #Example query for filtering by gender
    '''
    SELECT Recording_title
    FROM RECORDING_SPEAKER
    WHERE Gender = 'Male';
    '''
    #Only if the user checked off that gender, run the query getting the resulting recordings
    #Then do a union on all of the results of the genders that were checked off
    #in order to put them together and prevent duplicates
    gender = []
    genderSel = False
    gender1 = request.form.get('gender1')
    if gender1 != None:
        query = "SELECT Recording_title FROM RECORDING_SPEAKER WHERE Gender = '" + gender1 + "';"
        gender = connect(query)
        genderSel = True
        
    gender2 = request.form.get('gender2')
    if gender2 != None:
        query = "SELECT Recording_title FROM RECORDING_SPEAKER WHERE Gender = '" + gender2 + "';"
        gender = list(set(gender).union(set(connect(query))))
        genderSel = True
    
    gender3 = request.form.get('gender3')
    if gender3 != None:
        query = "SELECT Recording_title FROM RECORDING_SPEAKER WHERE Gender = '" + gender3 + "';"
        gender = list(set(gender).union(set(connect(query))))
        genderSel = True


    #Perform intersections on all of the filtering categories that were checked off
    rows = []
    rowSel = False
    if yearSel and topicSel:
        rows = list(set(years).intersection(set(topics)))
        rowSel = True
    elif topicSel:
        rows = topics
        rowSel = True
    elif yearSel:
        rows = years
        rowSel = True

    if rowSel and nationalitySel:
        rows = list(set(rows).intersection(set(nationality)))
    elif nationalitySel:
        rows = nationality
        rowSel = True

    if rowSel and jewishSel:
        rows = list(set(rows).intersection(set(jewish)))
    elif jewishSel:
        rows = jewish
        rowSel = True

    if rowSel and genderSel:
        rows = list(set(rows).intersection(set(gender)))
    elif genderSel:
        rows = gender
        rowSel = True

    # If nothing was checked off, return all of the recordings
    if rowSel == False:
        query = "SELECT Recording_title FROM RECORDING;"
        rows = connect(query)
    
    #Render the page with the resulting recordings
    return render_template('index.html', rows = rows)

#Function for superuser login
#Implemented on a group call by Jabili, Nicole, Lakaylah
@app.route('/log-in', methods=['POST'])
def login():
    #Example query for login
    '''
    SELECT Username
    FROM SUPERUSER
    WHERE Username = 'Username123' AND Password = 'Password123';
    '''
    #Cipher for Encryption
    password = [chr(ord(a) + 3) for a in request.form['pwd']]

    encryptedPwd = ""

    for p in password:
	    encryptedPwd = encryptedPwd + p

    #Check if username and password are in database
    query = "SELECT Username FROM SUPERUSER WHERE Username = '" + request.form['username'] + "' AND Password = '" + encryptedPwd + "';"
    exists = connect(query)

    #If it's in the database, render the superuser page
    #If not, display an error message
    if exists:
        return render_template('superuser.html')
    else:
        message = "Invalid Username or Password. Try again."
        return render_template('superuserlogin.html', message=message)

# Superuser transaction - display recording attributes, 
# speaker attributes, and transcript attributes given a 
# Recording title
# Implemented on a group call with Jabili, Nicole, and Lakaylah, 
# but primarily implemented by Jabili
@app.route('/all-attributes', methods=['POST'])
def all_attributes():
    #Example query
    '''
    SELECT *
    FROM SEL
    WHERE Recording_title = 'Dr. Paul Loser';

    SELECT Speaker_number, Name, Gender, Nationality, Is_jewish
    FROM REC_INTERVIEW
    NATURAL JOIN SPEAKER
    WHERE Recording_title = 'Dr. Paul Loser';

    SELECT Transcript_ID, Transcript_text
    FROM REC_HASTRANS
    NATURAL JOIN TRANSCRIPT
    WHERE Recording_title = 'Dr. Paul Loser';
    '''
    
    #query = "SELECT Recording_title FROM RECORDING WHERE Recording_title % '" + request.form['searchRecording'] + "';"

    recordingTitle = request.form['t1title']
    recordingTitle = recordingTitle.replace("'", "''")

    query1 = "SELECT * FROM SEL WHERE Recording_title % '" + recordingTitle + "';"
    query2 = "SELECT Speaker_number, Name, Gender, Nationality, Is_jewish FROM REC_INTERVIEW NATURAL JOIN SPEAKER WHERE Recording_title % '" + recordingTitle + "';"
    query3 = "SELECT Transcript_ID, Transcript_text FROM REC_HASTRANS NATURAL JOIN TRANSCRIPT WHERE Recording_title % '" + recordingTitle + "';"
    
    #run all the queries and get the attributes
    recordingAttributes = connect(query1)
    speakerAttributes = connect(query2)
    transcriptAttributes = connect(query3)
    
    #if there is a transcript, write it to a file
    #if there is not transcript, write that it doesn't exist to the file
    if transcriptAttributes:
        transcriptAttributes[0][1].replace("\\n", "\n")
        text_file = open("transcript.txt", "w")
        n = text_file.write(transcriptAttributes[0][1])
        text_file.close() 
        transcriptID = transcriptAttributes[0][0]
    else:
        transcriptID = "N/A"
        text_file = open("transcript.txt", "w")
        n = text_file.write("No transcript exists for this recording")
        text_file.close() 
    
    #If a recording exists, render a page with all of the attributes
    #If not, display an error message
    if recordingAttributes:
        return render_template('allattributes.html', recordingAttributes=recordingAttributes, speakerAttributes=speakerAttributes, transcriptID=transcriptID)
    else:
        message = "No such recording"
        return render_template('superuser.html', message=message)

#display the transcript -- implemented by Jabili
@app.route('/transcript/')
def transcript():
    #read from the file the transcript was written to
    text_file = open("transcript.txt", "r")
    content = text_file.read()
    text_file.close()

    #render the contents on the page
    return render_template('transcript.html', content=content)

#Add a recording tuple to the relation
#Implemented on a group call with all of us, but primarily by Jabili
@app.route('/add-recording', methods=['POST'])
def add_recording():
    #get all of the attributes
    recording = request.form['t2title']
    audio = request.form['t2link']
    year = request.form['t2year']
    interviewer = request.form['t2name']
    date = request.form['t2date']
    famBusiness = request.form['t2fambus']
    description = request.form['t2des']

    #replace ' with ''
    recording = recording.replace("'", "''")
    audio = audio.replace("'", "''")
    interviewer = interviewer.replace("'", "''")
    description = description.replace("'", "''")

    #make and run the query and get the returned key
    query = "INSERT INTO Recording(Recording_title, Audio_file, Interviewer_name, Year_recorded, Publication_date, Family_business, Description) VALUES('" + recording + "', '" + audio + "', '" + interviewer + "', " + year + ", '" + date + "', " + famBusiness + ", '" + description + "') RETURNING Recording_title;"
    
    returnedKey = connect2(query)

    #return a message regarding whether or not the insertion was successful
    if returnedKey != "":
        addRecordingMessage = "Insert successful!"
    else:
        addRecordingMessage = "Insert failed"
        
    return render_template('superuser.html', addRecordingMessage=addRecordingMessage)

#Add a transcript tuple to the relation
#Implemented by Nicole
@app.route('/add-transcript', methods=['POST'])    
def add_transcript():
    transcript = request.form['t3ID']
    text_file = request.form['t3file']
    recording = request.form['t3title']
    
    #read from the file
    recording = recording.replace("'", "''")
    textFile = open("" + text_file + "", "r")
    fileContent = textFile.read()
    textFile.close()
    content = fileContent.replace("'", "''")
    query1 = "INSERT INTO Transcript(Transcript_ID, Transcript_text) VALUES('" + transcript + "', '" + content + "') RETURNING Transcript_ID;" 
    query2 = "INSERT INTO HAS_TRANSCRIPT(Transcript_ID, Recording_title) VALUES('" + transcript + "', '" + recording + "') RETURNING Transcript_ID;"

    returnedKey1 = connect2(query1)
    returnedKey2 = connect2(query2)

    if returnedKey1 != "" and returnedKey2 != "":
        addTranscriptMessage = "Insert successful!"
    else:
        addTranscriptMessage = "Insert failed"
        
    return render_template('superuser.html', addTranscriptMessage=addTranscriptMessage)

#Add a topic/category tuple to the relation
#Implemented by Nicole
@app.route('/add-topic', methods=['POST'])
def add_topic():
    #get all of the attributes
    recording = request.form['t20title']
    topic = request.form['t20topic']

    #replace ' with ''
    recording = recording.replace("'", "''")
    topic = topic.replace("'", "''")

    #make and run the query and get the returned key
    query = "INSERT INTO TOPIC_OR_CATEGORY(Recording_title, Topic_or_category_name) VALUES('" + recording + "', '" + topic + "') RETURNING Recording_title;"

    returnedKey = connect2(query)

    #return a message regarding whether or not the insertion was successful
    if returnedKey != "":
        addTopicMessage = "Insert successful!"
    else:
        addTopicMessage = "Insert failed"
        
    return render_template('superuser.html', addTopicMessage=addTopicMessage)

#Add a speaker tuple to the relation
#Implemented by Nicole
@app.route('/add-speaker', methods=['POST'])
def add_speaker():
    speaker = request.form['t4name']
    gender = request.form['t4gender']
    nationality = request.form['t4nat']
    jewish = request.form['t4jew']
    recording = request.form['t4title']

    recording = recording.replace("'", "''")
    speaker = speaker.replace("'", "''")
    gender = gender.replace("'", "''")
    nationality = nationality.replace("'", "''")

    query1 = "INSERT INTO Speaker(Name, Gender, Nationality, Is_jewish) VALUES('" + speaker + "', '" + gender + "', '" + nationality + "', " + jewish + ") RETURNING Name;"
    query2 = "INSERT INTO Interview_With(Recording_title, Speaker_number) VALUES('" + recording + "', (SELECT Speaker_number FROM Speaker WHERE Name = '" + speaker + "' )) RETURNING Speaker_number;"

    returnedKey1 = connect2(query1)
    returnedKey2 = connect2(query2)

    if returnedKey1 != "" and returnedKey2 != "":
        addSpeakerMessage = "Insert successful!"
    else:
        addSpeakerMessage = "Insert failed"
        
    return render_template('superuser.html', addSpeakerMessage = addSpeakerMessage)

#Add a superuser tuple to the relation
#Implemented by Nicole    
@app.route('/add-superuser', methods=['POST'])
def add_superuser():
    username = request.form['t10username']


    username.replace("'", "''")

    #Cipher for Encryption
    password = [chr(ord(a) + 3) for a in request.form['t10password']]

    encryptedPwd = ""

    for p in password:
	    encryptedPwd = encryptedPwd + p

    query = "INSERT INTO SUPERUSER(Username, Password) VALUES('" + username + "', '" + encryptedPwd + "') RETURNING Username;"
    
    returnedKey = connect2(query)

    if returnedKey != "":
        addSuperuserMessage = "Insert successful!"
    else:
        addSuperuserMessage = "Insert failed"
        
    return render_template('superuser.html', addSuperuserMessage=addSuperuserMessage)

#Delete a recording tuple from the relation
#Implemented by Anthony
@app.route('/del-recording', methods = ['POST'])
def del_recording():
    recording = request.form['t5title']
    recording = recording.replace("'", "''")
    query = "DELETE FROM Recording WHERE Recording_title = '" + recording + "';"
    returnedNumDeletions = connect3(query)
    if returnedNumDeletions > 0:
        delRecordingMessage = "Deletion successful!"
    else:
        delRecordingMessage = "Deletion failed"
    
    return render_template('superuser.html', delRecordingMessage=delRecordingMessage)

#Delete a speaker topic/ category from the relation
#Implemented by Anthony   
@app.route('/del-topic', methods = ['POST'])
def del_topic():
    tName = request.form['t49name']
    tRec = request.form['t49rec']
    tName = tName.replace("'", "''") 
    tRec = tRec.replace("'", "''")
    query = "DELETE FROM TOPIC_OR_CATEGORY WHERE Recording_title = '" + tRec + "' AND Topic_or_category_name = '"+ tName +"';"
    returnedNumDeletions = connect3(query)
    if returnedNumDeletions > 0:
        delTopicMessage = "Deletion successful!"
    else:
        delTopicMessage = "Deletion failed"

    return render_template('superuser.html', delTopicMessage=delTopicMessage)

#Delete a transcript tuple from the relation
#Implemented by Anthony
@app.route('/del-transcript', methods = ['POST'])
def del_transcript():
    transcriptID = request.form['t6ID']
    transcriptID = transcriptID.replace("'", "''") #probably wont need this but just to be safe
    
    query = "DELETE FROM TRANSCRIPT WHERE Transcript_ID = '" + transcriptID + "';"
    query2 = "DELETE FROM HAS_TRANSCRIPT WHERE Transcript_ID = '" + transcriptID + "';"
    
    returnedNumDeletions = connect3(query)
    returnedNumDeletions2 = connect3(query2)

    if returnedNumDeletions > 0:
        delTranscriptMessage = "Deletion successful!"
    else:
        delTranscriptMessage = "Deletion failed"
    return render_template('superuser.html', delTranscriptMessage=delTranscriptMessage)

#Delete a speaker tuple from the relation
#Implemented by Anthony
@app.route('/del-speaker', methods = ['POST'])
def del_speaker():
    speakerNum = request.form['t7num']
    speakerNum = speakerNum.replace("'", "''") #probably wont need this but just to be safe
    
    query = "DELETE FROM SPEAKER WHERE Speaker_number = " + speakerNum + ";"
    query2 = "DELETE FROM INTERVIEW_WITH WHERE Speaker_number = " + speakerNum + ";"
    
    returnedNumDeletions = connect3(query)
    returnedNumDeletions2 = connect3(query2)

    if returnedNumDeletions > 0:
        delSpeakerMessage = "Deletion successful!"
    else:
        delSpeakerMessage = "Deletion failed"
    return render_template('superuser.html', delSpeakerMessage=delSpeakerMessage)


#Delete a superuser tuple from the relation
#Implemented by Anthony
@app.route('/del-superuser', methods = ['POST'])
def del_superuser():
    sUser = request.form['t50name']
    sUser = sUser.replace("'", "''") #probably wont need this but just to be safe
    query = "DELETE FROM SUPERUSER WHERE Username = '" + sUser + "';"
    returnedNumDeletions = connect3(query)
    if returnedNumDeletions > 0:
        delSuperuserMessage = "Deletion successful!"
    else:
        delSuperuserMessage = "Deletion failed"

    return render_template('superuser.html', delSuperuserMessage=delSuperuserMessage)

#Display the audio file link, transcript file, description of the recording, 
#publication date, and year recorded when the user selects a recording
#Implemented by Jabili
@app.route('/recording/', methods=['POST'])
def recording():
    recording = request.form.get('recording')
    recording = recording.replace("'", "''")
    #If the user didn't select a recording, just reset the page
    if recording == None:
        query = "SELECT Recording_title FROM RECORDING;"
        rows = connect(query)
        return render_template('index.html', rows=rows)
    recordingTitle = recording
    '''
    SELECT Audio_file
    FROM RECORDING
    WHERE Recording_title = 'Dr. Paul Loser';
    '''
    query = "SELECT Audio_file FROM RECORDING WHERE Recording_title % '" + recording + "';"
    audioFile = connect(query)[0][0]
    query = "SELECT Transcript_text FROM REC_HASTRANS NATURAL JOIN TRANSCRIPT WHERE Recording_title % '" + recording + "';"
    transcriptFile = connect(query)
    '''
    SELECT Description, Publication_date, Year_recorded
    FROM RECORDING
    WHERE Recording_title = 'Finkle, Herman "Humpsy"';
    '''

    #Run queries and get the resulting tuples
    query = "SELECT Description FROM RECORDING WHERE Recording_title % '" + recording + "';"
    des = connect(query)
    query = "SELECT Publication_date FROM RECORDING WHERE Recording_title % '" + recording + "';"
    pubDate = connect(query)
    query = "SELECT Year_recorded FROM RECORDING WHERE Recording_title % '" + recording + "';"
    yearRec = connect(query)
    query = "SELECT Topic_or_category_name FROM TOPIC_OR_CATEGORY WHERE Recording_title % '" + recording + "';"
    top = connect(query)

    #Set all of the values to be returned to what they are
    description = ""
    publicationDate = ""
    yearRecorded = ""
    topic = ""
    publicationDes = ""
    yearDes = ""
    topicDes = ""

    if des:
        description = "Description: " + des[0][0]
    if pubDate:
        publicationDate = pubDate[0][0]
        publicationDes = "Publication Date: "
    if yearRec:
        yearRecorded = yearRec[0][0]
        yearDes = "Year Recorded: "
    if top:
        topic = top
        topicDes = "Topics/Categories: "

    if transcriptFile:
        transcriptFile[0][0].replace("\\n", "\n")
        text_file = open("transcript.txt", "w")
        n = text_file.write(transcriptFile[0][0])
        text_file.close() 
    else:
        text_file = open("transcript.txt", "w")
        n = text_file.write("No transcript exists for this recording")
        text_file.close() 
    return render_template('recording.html', recordingTitle=recordingTitle, audioFile=audioFile, description=description, topic=topic, publicationDate=publicationDate, yearRecorded=yearRecorded, publicationDes=publicationDes, yearDes=yearDes, topicDes=topicDes)

#Update recording tuple in relation
#Implemented by Lakaylah
@app.route('/update-recording', methods=['POST'])
def update_recording():
    oldRecording = request.form['t8otitle']
    newRecording = request.form.get('t8ntitle')
    audio = request.form.get('t8link')
    year = request.form.get('t8year')
    interviewer = request.form.get('t8name')
    date = request.form.get('t8date')
    famBusiness = request.form.get('t8fambus')
    description = request.form.get('t8des')

    oldRecording.replace("'", "''")
    newRecording.replace("'", "''")
    audio.replace("'", "''")
    interviewer.replace("'", "''")
    description.replace("'", "''")

    exists = [False] * 8

    if oldRecording is not None:
        exists[0] = True
    if newRecording != '':
        exists[1] = True
    if audio != '':
        exists[2] = True
    if year != '':
        exists[3] = True
    if interviewer != '':
        exists[4] = True
    if date != '':
        exists[5] = True
    if famBusiness is not None:
        exists[6] = True
    if description != '':
        exists[7] = True

    oneExists = False

    query = "UPDATE Recording SET "
    for i in range(len(exists)):
        if exists[i] == True:
            if i == 1:
                part = "Recording_title = '" + newRecording + "'"
                query += part
                oneExists = True
            elif i == 2:
                if oneExists == True:
                    part = ", Audio_file = '" + audio + "'"
                else:
                    part = "Audio_file = '" + audio + "'"
                query += part
                oneExists = True
            elif i == 3:
                if oneExists == True:
                    part = ", Year_recorded = " + year
                else:
                    part = "Year_recorded = " + year
                query += part
                oneExists = True
            elif i == 4:
                if oneExists == True:
                    part = ", Interviewer_name = '" + interviewer + "'"
                else:
                    part = "Interviewer_name = '" + interviewer + "'"
                query += part
                oneExists = True
            elif i == 5:
                if oneExists == True:
                    part = ", Publication_date = '" + date + "'"
                else:
                    part = "Publication_date = '" + date + "'"
                query += part
                oneExists = True
            elif i == 6:
                if oneExists == True:
                    part = ", Family_business = " + famBusiness
                else:
                    part = "Family_business = " + famBusiness
                query += part
                oneExists = True
            elif i == 7:
                if oneExists == True:
                    part = ", Description = '" + description + "'"
                else:
                    part = "Description = '" + description + "'"
                query += part
                oneExists = True

    last_part = " WHERE Recording_title = '" + oldRecording + "';"
    query += last_part
    
    returnedKey = connect4(query)

    if returnedKey != "":
        updateRecordingMessage = "Update successful!"
    else:
        updateRecordingMessage = "Update failed"
        
    return render_template('superuser.html', updateRecordingMessage=updateRecordingMessage)

#Update transcript tuple in relation
#Implemented by Lakaylah
@app.route('/update-transcript', methods=['POST'])
def update_transcript():
    oldTID = request.form['t9oID']
    newTID = request.form.get('t9nID')
    text_file = request.form.get('t9file')

    oldTID = oldTID.replace("'", "''")
    newTID = newTID.replace("'", "''")
    text_file = text_file.replace("'", "''")

    exists = [False] * 3

    if oldTID is not None:
        exists[0] = True
    if newTID != '':
        exists[1] = True
    if text_file != '':
        exists[2] = True
        textFile = open("" + text_file + "", "r")
        fileContent = textFile.read()
        textFile.close()
        content = fileContent.replace("'", "''")

    oneExists = False

    query1 = "UPDATE Transcript SET "
    for i in range(len(exists)):
        if exists[i] == True:
            if i == 1:
                part = "Transcript_ID = '" + newTID + "'"
                query1 += part
                oneExists = True
            elif i == 2:
                if oneExists == True:
                    part = ", Transcript_text = '" + content + "'"
                else:
                    part = "Transcript_text = '" + content + "'"
                query1 += part
                oneExists = True
            print(i)

    last_part = " WHERE Transcript_ID = '" + oldTID + "';"
    query1 += last_part
    
    returnedKey1 = connect4(query1)

    if returnedKey1 != "":
        updateTranscriptMessage = "Update successful!"
    else:
        updateTranscriptMessage = "Update failed"
        
    return render_template('superuser.html', updateTranscriptMessage=updateTranscriptMessage)

#Update speaker tuple in relation
#Implemented by Lakaylah
@app.route('/update-speaker', methods=['POST'])
def update_speaker():
    spNum = request.form['t10num']
    spName = request.form.get('t10name')
    spGender = request.form.get('t10gender')
    spNationality = request.form.get('t10nat')
    spIsJewish = request.form.get('t10jew')

    spName = spName.replace("'", "''")
    spNationality = spNationality.replace("'", "''")

    exists = [False] * 5

    if spNum is not None:
        exists[0] = True
    if spName != '':
        exists[1] = True
    if spGender != '':
        exists[2] = True
    if spNationality != '':
        exists[3] = True
    if spIsJewish is not None:
        exists[4] = True

    oneExists = False

    query = "UPDATE Speaker SET "
    for i in range(len(exists)):
        if exists[i] == True:
            if i == 1:
                part = "Name = '" + spName + "'"
                query += part
                oneExists = True
            elif i == 2:
                if oneExists == True:
                    part = ", Gender = '" + spGender + "'"
                else:
                    part = "Gender = '" + spGender + "'"
                query += part
                oneExists = True
            elif i == 3:
                if oneExists == True:
                    part = ", Nationality = '" + spNationality + "'"
                else:
                    part = "Nationality = '" + spNationality + "'"
                query += part
                oneExists = True
            elif i == 4:
                if oneExists == True:
                    part = ", Is_jewish = " + spIsJewish
                else:
                    part = "Is_jewish = " + spIsJewish
                query += part
                oneExists = True

    last_part = " WHERE Speaker_number = '" + spNum + "';"
    query += last_part
    
    returnedKey = connect4(query)

    if returnedKey != "":
        updateSpeakerMessage = "Update successful!"
    else:
        updateSpeakerMessage = "Update failed"
        
    return render_template('superuser.html', updateSpeakerMessage=updateSpeakerMessage)

if __name__ == '__main__':
    app.run(debug = True)
