CREATE TABLE SPEAKER (
    Speaker_number SERIAL PRIMARY KEY, 
    Name VARCHAR(255), 
    Gender VARCHAR(50), 
    Nationality VARCHAR(255),
    Is_jewish BOOLEAN
);

CREATE TABLE RECORDING (
    Recording_title TEXT PRIMARY KEY, 
    Audio_file TEXT UNIQUE NOT NULL,/*I think we're making this a link*/
    Interviewer_name VARCHAR(255), 
    Year_recorded INT, 
    Publication_date DATE, 
    Family_business BOOLEAN, 
    Description TEXT,
    CHECK (Year_recorded > 1899 AND Year_recorded < 2021)
);

CREATE TABLE TOPIC_OR_CATEGORY (
    Recording_title TEXT,
    Topic_or_category_name TEXT,
    PRIMARY KEY (Recording_title, Topic_or_category_name)
);

CREATE TABLE INTERVIEW_WITH (
    Recording_title TEXT, 
    Speaker_number INT, 
    PRIMARY KEY (Recording_title, Speaker_number)
);

CREATE TABLE SUPERUSER (
    Username VARCHAR(255) PRIMARY KEY, /*might have to decrease this*/
    Password VARCHAR(255)
);

CREATE TABLE EDITED (
    Edit_ID SERIAL PRIMARY KEY, 
    Recording_title TEXT,
    Username VARCHAR(255), 
    Message TEXT
);

CREATE TABLE TRANSCRIPT(
    Transcript_ID CHAR(3) PRIMARY KEY, 
    Transcript_text TEXT
);

CREATE TABLE HAS_TRANSCRIPT(
    Transcript_ID CHAR(3), 
    Recording_title TEXT, 
    PRIMARY KEY (Transcript_ID, Recording_title)
);

ALTER TABLE TOPIC_OR_CATEGORY
ADD FOREIGN KEY (Recording_title) REFERENCES RECORDING(Recording_title)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE INTERVIEW_WITH
ADD FOREIGN KEY (Recording_title) REFERENCES RECORDING(Recording_title)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE INTERVIEW_WITH
ADD FOREIGN KEY (Speaker_number) REFERENCES SPEAKER(Speaker_number)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE EDITED
ADD FOREIGN KEY (Recording_title) REFERENCES RECORDING(Recording_title)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE EDITED 
ADD FOREIGN KEY (Username) REFERENCES SUPERUSER(Username)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE HAS_TRANSCRIPT
ADD FOREIGN KEY (Transcript_ID) REFERENCES TRANSCRIPT(Transcript_ID)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE HAS_TRANSCRIPT
ADD FOREIGN KEY (Recording_title) REFERENCES RECORDING(Recording_title)
ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO SPEAKER (Name, Gender, Nationality, Is_jewish)
VALUES ('Herman "Humpsy" Finkle', 'Male', NULL, TRUE); 

INSERT INTO SPEAKER (Name,Gender,Nationality,Is_jewish)
VALUES ('Dr. Paul Loser', 'Male', NULL, FALSE);

INSERT INTO SPEAKER (Name, Gender, Nationality, Is_jewish)
VALUES ('Joel Millner', 'Male', 'Polish', TRUE);

INSERT INTO RECORDING (Recording_title, Audio_file, Interviewer_name, Year_recorded, Publication_date, Family_business, Description)
VALUES('Millner, Joel', 'https://archive.org/details/JHS13SideA', 'Not Mentioned', 1990, '1995-05-31', TRUE, 'JHS 13 31 May 1995 Joel Millner, at his office Millner Lumber Side A: Largely a discussion of the Millner family genealogy and ancestors. His father Nathan was born in the 1880s and the family lived in Elizabeth, N.J. before moving to Trenton. He worked as a businessman for many years and passed the family tradition of entrepreneurship to his sons and grandsons. Side B: Blank.');

INSERT INTO Recording(Recording_title, Audio_file, Interviewer_name, Year_recorded, Publication_date, Family_business, Description)
VALUES('Dr. Paul Loser', 'https://archive.org/details/OralHistroyWithDr.PaulLoserSideA', 'Not Mentioned', 1970, '1976-08-12', FALSE, 'Dr. Paul Loser by Harold Perry, 12 August 1976');

INSERT INTO Recording (Recording_title, Audio_file, Interviewer_name, Year_recorded, Publication_date, Family_business, Description)
VALUES ('Finkle, Herman "Humpsy"', 'https://archive.org/details/JHS10SideA', 'Not Mentioned', 2000, '2003-10-16', FALSE, 'JHS 10 16 October 2003 Herman "Humpsy" Finkle Side A: Interviewed at his house. Most of the interview consists of miscellaneous reminiscences of "Jewtown" (the Jewish neighborhood in South Trenton) between the mid-1930s and 1940s. Recalls the YMHA (Young Men''s Hebrew Association) on Stockton Street, and many businesses (including Herman Spiegel Furniture and a drugstore) near the intersection of Market and Lamberton Streets. At the beginning of WW2, worked at the GM Factory in Ewing Township. Later entered the service and visited Palestine before it became the State of Israel. Mentions one Benny (?) Olinsky as the "keeper of Jewish history in Trenton." Side B: Blank.');

INSERT INTO TOPIC_OR_CATEGORY (Recording_title, Topic_or_category_name)
VALUES ('Dr. Paul Loser', 'Trenton'), ('Dr. Paul Loser', 'N.J.'), ('Dr. Paul Loser', 'Education');

INSERT INTO TOPIC_OR_CATEGORY (Recording_title, Topic_or_category_name)
VALUES ('Millner, Joel', 'Jewish'), ('Millner, Joel', 'Trenton'), ('Millner, Joel', 'N.J.'), ('Millner, Joel', 'Business');

INSERT INTO TOPIC_OR_CATEGORY (Recording_title, Topic_or_category_name)
VALUES ('Finkle, Herman "Humpsy"', 'Jewish'), ('Finkle, Herman "Humpsy"', 'Trenton'), ('Finkle, Herman "Humpsy"', 'N.J.'), ('Finkle, Herman "Humpsy"', 'World War II');

INSERT INTO INTERVIEW_WITH(Recording_title, Speaker_number)
VALUES ('Millner, Joel', (
SELECT Speaker_number
FROM Speaker
WHERE Name = 'Joel Millner'
));

INSERT INTO INTERVIEW_WITH(Recording_title, Speaker_number)
VALUES ('Dr. Paul Loser', (
SELECT Speaker_number
FROM Speaker
WHERE Name = 'Dr. Paul Loser'
));

INSERT INTO INTERVIEW_WITH(Recording_title, Speaker_number)
VALUES ('Finkle, Herman "Humpsy"', (
SELECT Speaker_number
FROM Speaker
WHERE Name = 'Herman "Humpsy" Finkle'
));

INSERT INTO SUPERUSER(Username, Password)
/*encrypted Password123*/
VALUES('Username123', 'Sdvvzrug456');
/*Need to be in role of superuser for this to work*/
/*CREATE USER Username123 WITH PASSWORD 'Password123';
GRANT SELECT, INSERT, DELETE, UPDATE ON RECORDING, SPEAKER, TOPIC_OR_CATEGORY, INTERVIEW_WITH, TRANSCRIPT, HAS_TRANSCRIPT TO Username123; */

INSERT INTO TRANSCRIPT(Transcript_ID, Transcript_text)
VALUES ('001', 'JHS 10: Finkle, Herman “Humpsy”
KEY
SPEAKER 1: interviewer
SPEAKER 2: interviewee (Herman “Humpsy” Finkle)
Tags-
* [? place], [? name ]
* [? unclear] = something I could hear but wasn’t 100% sure of
* [? inaudible ] = something I couldn’t guess or couldn’t hear
* [ _______ ] = audio cutting out at end of recording
[00:00]
SPEAKER 1 : Alright, now, uh, uh, We are sitting in the, the apartment of Humpsy Finkle and of course I don’t know how many people knew that Herman was his first name. Cause everyone calls him that. So alright, well go ahead and, uh, uh just give me some information
SPEAKER 2 : Ok I would say, start at the Y downtown on Stockton Street, about 1935 or so and remember they had the little swimming pool downstairs and that was the, eh, in place to go, where you met and played basketball, ah swimming, ah I remember the pool was very short and when Jackie Pollack [? name ] would dive in we’d be at the other end already. And he’s start swimming there and that’s how  he became a good swimmer 
[01:00]
and he went to Trenton High and got on the swimming team. 
SPEAKER 1 :  Now that building, was that a, a, a telephone company at one time? 
SPEAKER 2 :  I think it was an old bell telephone building and eh I don’t know when they took it over, but at that time Fanny Buttson [? name ] was the, eh, director and the main office and eh we called him shaky – John Scholshberg [? name ] or eh Sydney Schloshberg [? name ], John’s brother, was eh an assistant there or something. He was the one who would throw you out or suspend you if you did something wrong
SPEAKER 1 :  Probably in the sports section or something
SPEAKER 2 :  Yeah, and, uh, I’m trying to think back on some of the people there but I know we played basketball, ya had to dress downstairs below street level and go all the way up to the top floor to the gym
SPEAKER 1 :  Not an elevator
SPEAKER 2 :  No elevator, only stairs, no elevators then 
[02:00]
and that was, eh, it ya know you had a lounge area, ya had the recreation room in the back with a pool table, and, uh,  a lot of basketball leagues and uh you’d go there to try to meet girls cause they had some girls clubs too and activities and that was it that was the hub of downtown, eh, Trenton
SPEAKER 1 :  Now how old were you when you started going there
SPEAKER 2 :  I would say we lived downtown about 10 years old
SPEAKER 1 :  10 years old, did you live close to there?
SPEAKER 2 :  Well walking distance, lived on Market Street, eh, down near Lamberton, well Lamberton Street for a while, then around the corner on Market Street, and lived above Barrens Cleaning Store 
SPEAKER 1 :  Okay now did any of them have eh a license to drive when they got 17 or 18?
SPEAKER 2 :  I’m trying to think somebody had a car, and I can remember who it was and I know about that time 
[03:00]
gas was about 11-12 cents a gallon and we used to chip in and 4 or 5 of us would chip in and the guy had an old beat up ford and we’d drive down the shore to Asbury Park or Belmar and back. But I know we’d chip in about 15 – 20 cents each it was enough to go back and forth [laughs] and live it up
SPEAKER 1 : Okay now the social activities, ah I remember that up in the gym is where they had the dances
SPEAKER 2 :  Dances and basketball and shows, when they had, that was everything, they had a little stage there, in fact when you played basketball you had to be careful, they would bounce you into the stage ya know, uh, you got contact and you could get hurt but they had the stage, and, they always, one, one ceiling was low because when you chose up, you would would defend a high basket or low basket at the beginning eh they had a big skylight and an 
[04:00]
arch way, so if you had the high basket you could loft the shot up in there if you had the low basket you couldn’t do anything but drive in and get a little bank shot or a low shot, but, uh, i remember they had some I remember great games there of course the bigger guys Gil Susmen [? name ] and Red Bloomenthal [? name ] that played, eh the Rosenthals, Sharky, played there and the Farbers [? name ] ya know quite a crew. And then of course the clubs, they had several clubs there and then we had a basketball league and eh that was I would say I was about 15 when I went into the Allenbys and eh
SPEAKER 1 :  Alright so that was already in existence when you showed up
SPEAKER 2 :  yeah they they had a little older crew and I guess they drifted away and if I remember Alby Byer [? name ] was the, uh, advisor for the club and we had eh I’m trying to remember, uh, Leon Rosenberg, 
[05:00]
Leon Skull, Carl Bromawitz, Harold Crown, myself, uh, Lester Bowtof, Herby Clark, Lenny Cone, little GB Tempkin, Joe Lusgarden, eh guy named Sid Baneck [? name ], I don’t know if
SPEAKER 1 :  Everyone of them had a nickname too
SPEAKER 2 :  Yeah Carl Bromawitz was Doodle Bug, I was of course Humpsy, GB was just plain GB I can’t remember all of the others but, but everybody had a name
SPEAKER 1 :  Well did you know why the boys had a nickname and not the girls
SPEAKER 2 :  No
SPEAKER 1 :  The mothers were very shrewd when the boy comes home from wherever he was I just heard that this one was in trouble and everything else and what was his name 
[06:00]
eh schmoyle, well I don’t know anybody by that name because the mothers did not know the nicknames of the boys, the girls were lily white [OVERLAP]
SPEAKER 2 :  Oh, yeah.
SPEAKER 1 :  so they didn’t have to have
SPEAKER 2 :  That’s why everyone wanted girls, [laughs] they were easier
SPEAKER 1 :  While we are on that subject, when from you personally, uh, when did you go up to there to start dancing with any of them
SPEAKER 2 :  Eh, about 15 years old, yeah
SPEAKER 1 :  What grade would you be in, a sophomore
SPEAKER 2 :  I was 15, just finishing eh, ninth grade, I was in tenth grade in Trenton High
SPEAKER 1 :  Okay a freshman in Trenton High, sophomore, junior no a sophomore
SPEAKER 2 :  Sophomore yeah
SPEAKER 1 : Okay and then, uh, was there any, I know there were little groups because after the war and I was up there 
[07:00]
shooting pictures and I remember different groups would be formed like this ya know in a circle
SPEAKER 2 :  Right
SPEAKER 1 :  So, uh, you know, when, when you were there were they sep- you know, not segregated but they chose themselves to be in a group and if you walked over to that group and if it were a little lower level than the other group then other group doesn’t have anything to do with you
SPEAKER 2 :  Yeah cliques we had
SPEAKER 1 :  The west, the west end west statesmen
SPEAKER 2 :  West Trenton and what we’d call Hiltonia, the elite [laughs] and we’d call Crapper Hill those days, uh, because they all lived in fancy places and we’d say oh they can only afford to eat crappers that’s, uh, what we called Crapper Hill but I used to deliver when I got my license I’d deliver for Gil Zarnosky [? name ] became Gil Zarn 
[08:00]
and food and produce used to deliver out there. And eh oh also the Hoduses [? name ] I remember and Jackie Hodus [? name ] eh, was in the group, Eddie Berkowitz [? name ] um but there  was quite a crew. And then yeah, so we had basketball leagues and we had dances and you could always go down and swim uh remember they always rubbed you around make sure no dirt was on you after you showered before you went in the pool, and, uh
SPEAKER 1 :  Now was there any teams that travelled out of the area to other Jewish, uh, cities
SPEAKER 2 :  They, they had the older guys, they had a travel team that played the other Y’s remember there was a big rivalry with the Perth Amboy Y and Plainfield Y and they used to travel to play them, back and forth, eh, but not the younger guys
SPEAKER 1 :  Okay, well, then, were you on the, on the basketball team that they called the senior team 
[09:00]
SPEAKER 2 :  No, uh, we were on the club teams, ya know, Allenby played Cardosa and I forget who the other ones were
SPEAKER 1 :  Well, well, then, well then that group wouldn’t be the ones that would be playing
SPEAKER 2 :  No, but you had some players from those clubs that were on the big team
SPEAKER 1 :  Ok and what was that, what was the name of the YMH, the YM-
SPEAKER 2 :  It was the Trenton Y, Trenton YHMA
SPEAKER 1 :  Ok
SPEAKER 2 :  And they played other YMHA’s maybe some outside teams other but there was a, there was a Hebrew league [laughs] really
SPEAKER 1 :  Well, I guess there would be
SPEAKER 2 :  Yeah
SPEAKER 1 :  Because you play your own kind
SPEAKER 2 :  Yeah
SPEAKER 1 :  Okay so now uh here comes the war now, and uh most have the same group you had, a lot of them joined a lot of them drafted but they would all be I think from 18 and on up
SPEAKER 2 :  Yeah we were, most of us when the war broke out were seniors in high school and I remember coming down 
[10:00]
as I said from playing basketball and you had to come down the 3 flights, oh actually 4 flights of stairs to get to the locker room but the first floor had the lounge and as we were coming down it was a winding case and you always pass the lounge to go down before you got downstairs and the guys were huddled around some of the people huddled around the radio and said that the Japanese had bombed Pearl Harbor so we all went in to listen and that’s when we first heard about it it was on that Sunday morning and eh of course a couple of the guys wanted to go enlist right away but you couldn’t and I remember a couple of, uh, guys from Trenton High football team tried to go to Canada to enlist and they were turned back but that was the, that was it, it was senior year. And then I went to work after high school I worked at General Motors for a couple of years before I went in the service, and, uh, so did several of the other guys
SPEAKER 1 :  Okay by that time when you were at General Motors, eh, the automobile manufacturing 
[11:00]
was done
SPEAKER 2 :  Oh yeah, they were making torpedo bombers, yeah, I remember another one downtown with Howard Weiss [? name ], uh, downtown, uh, the Cherowitzes [? name ] they took quite a crew with 
SPEAKER 1 :  Okay now when you, when you left General Motors did you go directly into the service or, or were you- were you-
SPEAKER 2 :  No I, I went in the service
SPEAKER 1 :  Okay now where did you train, your basic training
SPEAKER 2 :  Eh, well of course we were inducted at Fort Dix and then from there and after a couple of days we shipped out to Camp Grand Illinois [? place] And eh that was where we took basic and then went over to, to Fort Benjamin Harrison in Indiana and did, uh, medical training and from there went to Fort Lewis Washington [? place] for more training and then I’m trying to think, 
[12:00]
from there, oh yeah, from there was a couple of trips on a, a hospital ship and that was it then we got stationed in Brigham City, Utah [? place] in an army general hospital it was eh, eh, it wasn’t a mash unit at that time they didn’t, of course, they didn’t have the mnemonics, then- 
SPEAKER 1 : Okay well then 
SPEAKER 2 :  Everything was spelled out.
SPEAKER 1 : You were were you a uh, um, a, uh, I forgot, there were, a hospital corpsman 
SPEAKER 2 :  Right
SPEAKER 1 :  And then there were a, there was a bunch that got a referred rate, there was another name for it Sergeant, or First Sargent or Corporal 
SPEAKER 2 :  Well there was Private First Class, we had Private, Private First Class, Corporal, Sergeant, eh then a one, a one rocker they had a stripe underneath was like a staff sergeant and then the top was a master sergeant at that time
SPEAKER 1 :  See because in the Navy they had pharmacists [inaudible]
SPEAKER 2 :  Right and we were just medics, yeah corpsmen, 
[13:00]
and uh that’s what I was and then I wound up, uh, at the Bushnell General Hospital I wound up as a medical NCL in charge of surgery 
SPEAKER 1 :  Okay now were they by that time, uh, a was bunch, uh, a bunch of wounded coming in from overseas 
SPEAKER 2 :  Yeah yeah at that time, uh, in fact, I was there let’s see, 1945 and the war ended and, you know, we were pretty big as far as a head injuries and amputations and stuff and after a while I guess we got into 1946 and things were slowing down they started winded up doing minor surgery, ya know, eh, like, eh, things like, oh, almost anything, eh, you know, like, they came in with any kind of injury didn’t have to be war related and then when I got discharged the 
[14:00]
hospital was still there I didn’t know what they did with it but I had, eh, made friends with people in Brigham City [? place] and I think in 1950-51 I came back from visiting my brother in California and I stopped there and then the, eh, the hospital that-
SPEAKER 1 :  Which brother was that?
SPEAKER 2 :  Eh Henry he lived in, eh, California, and I stopped there to see the friends and the, eh, hospital had become a Navajo Indian school so that’s what it is, I don’t know if it is still there or still in existence but I remember it was set at the base of the Wasatch Mountains [? place], Rocky Mountains Range and had beautiful, eh, bing cherry orchard around it and uh plums at one end and white peaches around the other, beautiful setting out there yeah
SPEAKER 1 :  There, there weren’t any of those when you were out there, was there, I mean, uh, in the, in the service
SPEAKER 2 :  What the orchards?
SPEAKER 1 :  Yeah
SPEAKER 2 :  Oh yeah they were 
[15:00]
blooming we used to 
SPEAKER 1 :  Oh and there was some stuff missing from the limbs
SPEAKER 2 :  We used to, we used to go, uh, pick the cherries and put them in the freezer in the, uh, surgery where they kept the, uh, medical supplies and just suck on them, they were great, [laughs] to warm them up 
SPEAKER 1 :  Well I’ve … Ok now, now the war is over and you are home what, what have you done, when you came home 
SPEAKER 2 :  Well I, eh, applied to college, under the GI Bill, while I was still in service, anticipating being discharged in time because they were breaking up the hospital and we knew we were going to get out and, uh, in fact I had gone into the army reserve also for a hitch and I got accepted and, eh, I got home in, eh, May,  May of ‘46 and that September I, uh, went to Franklin Marshall College [? place ], uh, 
[16:00]
in fact Howard Levenson [? name ] who is a doctor now was there on a navy program, uh, I guess they called it v5 or something
SPEAKER 1 :  Oh it was, v, v5 was the air and v12 was the, was the other, uh 
SPEAKER 2 :  Ground okay but anyhow I wound up going there and graduated 1950 and of course when I graduated job market was miserable there was nothing around and that’s when I would up, eh, driving a truck again for, eh, Fred F Buck’s Fruit and Produce on Tucker Ttreet that’s where Tafty Popkin [? name ], had, eh, Popkin brothers down there, and, eh, the packing houses were all around there, in fact, my, my, eh, senior year, was, Armond Ruterman [? name ] was, eh, a year ahead of me, well they, they had gone right from high school, I came 
[17:00]
from service, so they were a little ahead of me graduating but Armond, Harvey Stern [? name ], and eh, eh, Davey Silverstein [? name ] were at F&M and I was there with, eh, with Howard’s brother Neil, he, he was there for a year then he dropped out, but, uh, Howard had graduated from there, then so I, I drove the truck for a while and then, uhwent to work with my brother in law, got a chicken market, uh, Country Style Poultry [? place] on Fall and Union Street, right opposite the old school
SPEAKER 1 :  So you, did, did you go to med school?
SPEAKER 2 : No I never made it into med school
SPEAKER 1 : Okay.
SPEAKER 2 :rades weren’t that good and ya know figured didn’t have the money either at that time if things did work out, I did get interviewed at Temple University, but, I didn’t get in
SPEAKER 1 :  So when did you meet your wife, what, what was your wife’s name?
SPEAKER 2 :  Renee Filin [? name ], F-I-L-I-N, yeah her father was a tailor, eh
[18:00]
SPEAKER 1 :  In Trenton?
SPEAKER 2 :  Yeah, he did a lot of the work for some of the clothing stores ya know the alterations and then he had his own place up above uh Leventhal Shoe Store [? place] on Warren Street, but I met her uh oh for a while, too, I worked for the Tracey 5 & 10 and one of the fellas there, uh, we were playing cards, and he brought Renee over there was a friend of his wife
SPEAKER 1 :  What was her first name?
SPEAKER 2 :  Renee
SPEAKER 1 :  Renee
SPEAKER 2 :  And uh the other one was uh
SPEAKER 1 :  Now how do you spell that? 
SPEAKER 2 :  R-E-N-E-E
SPEAKER 1 :  Okay
SPEAKER 2 :  She pronounced it Renee, eh, we were playing cards and she was there and I took her home and that was the beginning of it [laughs]
SPEAKER 1 :  And what, what, what date were you married?
SPEAKER 2 :  We got married August twelfth 1956, and had 40 years in and, uh, they say then we finally sold our house it was getting to be too much 
[19:00]
with the stairs and everything and we moved in here December first and we were making plans to get, you know, another place and March first she died, so we got three months here right tothe day and that was it 40 years
SPEAKER 1 :  Ok now when you uh I, I’d like to try to work into this, uh, Allenby? Because I, I knew I told you I had a framed letter from Cheryl Allenby authorizing you, the club, to use his name
SPEAKER 2 : Yeah that was, started before I got into it, but I don’t remember the older guys, I said I do remember Alby Byer [? name ] was the advisor and uh that was that’s it it was named after General Allenby I guess, uh, I didn’t realize they had his permission with the letter, but ya know he was a 
[20:00]
big hero in Palestine at that time, they bailed out the British Army [laughs]
SPEAKER 1 : Okay now the British Army, there was, if I remember, there was a bridge that they had, had to cross to take over Palestine do you remember what that?
SPEAKER 2 :  I think that was the Allenby Bridge they named
SPEAKER 1 :  they named it the Allenby Bridge there too?
SPEAKER 2 :  Yeah, and, uh he evidently was quite a general, and, eh, from what I understand, eh, really was, eh, quite beneficial in, in winning over, ya know, Palestine from the British and of course then their mandate, eh, didn’t work out too well, but that’s it
SPEAKER 1 : Now do you, maybe I’ll, I’ll check somebody over, I don’t know how good their records are at the Jewish community center whether they saved any of that club material or not
SPEAKER 2 : I gave them 
[21:00]
some pictures that were on the wall, uh, I don’t know if they still are, about some of the athletic programs, some of the clubs 
SPEAKER 1 : Yeah well I saw, I saw some of the basketball teams that were there
SPEAKER 2 : Right, we also played, uh, we had a softball team from the Y, I was on, with Norm Stern [? name ], I remember, and Charlie Simmons [? name ], he was an alien, [laughs] he was on the team, we used to play in the city softball league um they had in fact the athletic director at the time was, eh, Hal Leftwich, uh Leftcord [? name ], rather
SPEAKER 1 : Leftcord yeah
SPEAKER 2 : Uh, and he was, you know, he ran the team, um can’t remember who else was on, but, uh 
SPEAKER 1 :  Well I remember seeing a photograph like this [SPEAKER 2 coughs] with a bunch of thumbnail photos and I remember Gil Susmen [? name ] was in one and I don’t recall who 
[22:00]
if I look at it again uh I’ll probably there may be some names underneath
SPEAKER 2 :  Well there’s all the Susmens [? name ] were involved in all the clubs, uh my brother, I think my brother they were in the Cardosa club there was the Trooper club, uh Herman Trabell Rouchie [? name ] was one of them my brother Abe was in one of the clubs, uh, trying to, Henry, uh, Gil Sussman, Al Sussman, Rubie [? name ] came along later I know he played basketball there with Willie Cone [? name ] and those guys at that time
SPEAKER 1 : Your brother, uh, one of your brothers uh Genie Saperstein [? name ]
SPEAKER 2 : Yeah Sid
SPEAKER 1 : Sid, oh
SPEAKER 2 : Sid married Genie
SPEAKER 1 : I took their wedding pictures
SPEAKER 2 : Yeah I, I think you and uh
SPEAKER 1 : Yeah Bernie 
SPEAKER 2 : Bernie uh
SPEAKER 1 :  I forgot his last name, he died just recently
SPEAKER 2 :  Bernie Reese [? name ]
SPEAKER 1 :  Reese yeah
SPEAKER 2 :  Uh, did our wedding too
SPEAKER 1 : Yeah that was, 
[23:00]
we- we had quite a, quite an organization then
SPEAKER 2 : Yeah, sure, I got the album, our wedding album there
SPEAKER 1 : Ya still have it
SPEAKER 2 : Yeah [laughs]
SPEAKER 1 : Ok now uh was there any, a lot of people say well the clubs are only for a good time but, uh, some, uh, somewhere along the line I got the feeling that there was select activities that would be pointing towards either helping the poor or driving someplace or something was there anything involved with the Allenby club, that
SPEAKER 2 : Not at that time, the clubs were pretty much like your social life and didn’t do much, at that time ya know, that, not that many people had a car there wasn’t that kind of money around really so it was really a place to go and gather and be with the guys the big activity, uh, I [laughs] remember was 
[24:00]
playing catch 5 on the steps of the armory which was right behind the building cause if you got caught playing cards in the Y, then they suspended you
SPEAKER 1 :  Okay well when they when they went into the new building, [inaudible] that kind of activity had long gone
SPEAKER 2 : Oh yea
SPEAKER 1 : Because that was I think by 1963 or 4
SPEAKER 2 : Yeah they moved out of downtown of course everybody was grown and married and matured and ya know things changed, lifestyles changed, and uh just didn’t do those things anymore, I don’t even know if they have clubs there anymore 
SPEAKER 1 : No
SPEAKER 2 : Ya know it’s but that was the, the social, uh, life at that time was being in a club and ya know playing ball with them, and, we used to have doggie roasts I remember we used to, we used to go to, uh, Lake 
[25:00]
Carnegie for canoe trips with your dates ya know drive out there I think at that time like a quarter an hour to rent a canoe. And uh sometimes had beach parties down the shore but you didn’t have that kind of money where you could go like night clubbing. The big thing I know the older guys, my brother, the Sussmens and they would take their dates to the West End Casino by Long Branch and they used to have name bands there, in fact, I think a lot of them had their, eh, would have their high school, uh, parties or afterwards affairs go out there yeah they would go there after the prom, we never did it, the younger group I think by the time, eh, the war was on and then when the war ended it was a whole different ballgame your thinking was different, uh, ya know I guess that is when the clubs disbanded, really
[26:00]
SPEAKER 1 : Well, the meeting place was there by Ben’s Deli
SPEAKER 2 : Oh yea
SPEAKER 1 : Right down on that corner
SPEAKER 2 : Yeah, yeah, uh, Waldman’s Barber Shop [? place] you had Ben’s Del and you had the cachumpkee the card club and the, uh, uh, Applebaum [? name ] had the news stand in front of Ben’s, Benny Hock [? name ] had the kosher restaurant across the street
SPEAKER 1 : Who had a gas station down on the corner
SPEAKER 2 :  Oh, uh, Jack Daner [? name ]
SPEAKER 1 : Jack Daner
SPEAKER 2 : Yeah, oh yeah, they had a station there for a long time, uh, right on the corner where Mill Street, and Market and Union all came together 
SPEAKER 1 : See because when they when they started tearing down Market Street a lot of them moved to Levittown 
SPEAKER 2 : Yeah that’s when it was getting done, yeah
SPEAKER 1 : Because I had been, ya know, I had the, uh, the AAMCO transmission place the one in Bristol after I sold the deli so I got, uh, 
[27:00]
ya know, I would get over there a lot of times in Levittown cause it was right around, I was in Bristol, and they were in Levittown
SPEAKER 2 : Yeah
SPEAKER 1 : And we used to go over and have lunch and then-
SPEAKER 2 : Oh yeah
SPEAKER 1 : -and then they disappeared down to Florida.
SPEAKER 2 : Yeah they drifted away shoulda big, eh, spot was Herman Spiegel’s [? name ] furniture store
SPEAKER 1 : Yeah.
SPEAKER 2 : And Sully’s drug store was right at the, the point with the store around it
SPEAKER 1 : Well that well where Herman Spiegel was, that was a Morton house
SPEAKER 2 : At one time yeah, yeah
SPEAKER 1 : At one time and boy they used to get some information about that Morton house
SPEAKER 2 : Oh my god [laughs] and then they had of course the, uh, at the point was the MCFA
SPEAKER 1 : Oh yeah
SPEAKER 2 : At the, little, uh, little old, uh, shoe there
SPEAKER 1 : Little triangle building
SPEAKER 2 : Yeah where Mill and, uh, Market split and uh that was quite the thing
SPEAKER 1 : Every, every Jewish boy wanted to be the lifeguard at the MCFA
SPEAKER 2 : Yeah [laughs] 
SPEAKER 1 : That is what they’d say
SPEAKER 2 : (laughing) That was a 
[28:00]
big wish
SPEAKER 1 : Yeah. But ya know I talked I uh if you if anything comes up in your thoughts 
SPEAKER 2 : Right
SPEAKER 1 : that you didn’t say, well write them down, because I, let me see today is the 8th 
BOTH: the 8th yeah
SPEAKER 1 : the 8th, and my let’s see the deadline is [inaudible] about the 15th or 16th I got a I have a deadline it has to be in the, in the office and then a week later it comes out
SPEAKER 2 : right
SPEAKER 1 : So, uh, ya know, we don’t have a lot of time but I can piece it together
SPEAKER 2 : But I, eh, couldn’t think of too much really
SPEAKER 1 : I’m going to I’m going to talk to the, uh, the, uh, executive director of the Jewish center to see if they 
[29:00]
have anything left hidden someplace
SPEAKER 2 : There must be stuff over there in the archives somewhere because a lot of us gave ya know I gave pictures, uh
SPEAKER 1 : Well I tell you who had a lot of it was Patty O’Linsky [? name ] 
SPEAKER 2 : Yeah yeah
SPEAKER 1 : And he gave me a lot of the stuff for the teams and I’m gonna pull some of that out
SPEAKER 2 : Yeah that’s right he played he come to think of it Benny Rednesblock [? name ] 
SPEAKER 1 : Oh yeah
SPEAKER 2 : Uh Erv, Erv Ulinski [? name ] who was Erv Olden [? name ] ya know, uh, taught at Trenton High in f fact I had him for a gym teacher for a while
SPEAKER 1 : Well wasn’t there another
SPEAKER 2 : Lou, uh
SPEAKER 1 : The one thatchanged his name to Olden
SPEAKER 2 : Zelig
SPEAKER 1 : That was uh who worked for Anchen Paper
SPEAKER 2 : Yeah that was, uh, Zelig I think he became Olden also
SPEAKER 1 : No there was Harold… Harry
SPEAKER 2 : Oh, eh, that’s right
SPEAKER 1 : Harry Olden [? name ]
SPEAKER 2 : Yeah the little chubby guy
[30:00]
SPEAKER 1 : Yeah Harry when he, eh, when he and Benny, uh, had the TVs in the hospitals
SPEAKER 2 : Yeah
SPEAKER 1 : Harry used to go in there late in the evening and if there was an empty bed he always had a nurse to go to. [SPEAKER 1 laughs] He was quite a character.
SPEAKER 2 : A character
SPEAKER 1 : He was quite a character
SPEAKER 2 : Yeah I remember oh that’s right one of the guys that was an office worker there at one time was Billy Kipperman [? name ], they moved out west, Lady Gordon and Sam Gordon [? name ] well they’re both judges I guess Sam when my brother still lived in Los Angeles, they used to have a Trenton group get together, Sam Gordon, and Joey Levitt [? name ], uh, Lady Gordon moved out there uh, trying to think, oh Mickey Daner [? name ] uh Tyler Bogag, Bogag, 
[31:00]
eh, Milt Bogag  [? unclear]
SPEAKER 1 : Oh yeah
SPEAKER 2 : They went out there. Quite a few went out that way but uh the old memory isn’t what it used to be [SPEAKER 2 laughs] ya know people drift and forget what goes on
SPEAKER 1 : Well especially and, uh, and I’ll say[ _______ ]');

INSERT INTO TRANSCRIPT(Transcript_ID, Transcript_text)
VALUES ('002', 'Soundfile: https://archive.org/details/JHS13SideA
JHS 13 (Jewish Historical Society)
Interviewee: Millner, Joel
Interview Date: May 31, 1995
Transcribed by Jacob Haney
INTERVIEWER: Today is, uh, May the 31st 1995, I’m sitting with, uh, Joel Millner in his spacious office, and uh we’re gonna explore a little more information of his dad Nathan Millner, which I recall him very well, uh, a few years back. Uh, the first thing, uh, J I wanna do is to clarify, uh, this first date when he was born. What year was he born? It’s—I had somebody mention somewhere 1884
JOEL MILLNER: Ummmm, [pause], I just wanna, uhhh, make sure ‘84?
INTERVIEWER: Because his hundredth birthday is what you have at, on the tape—
JOEL MILLNER [interrupting]: Yeah, well that was it, it was August 25th uh—
[1:00]
INTERVIEWER [interrupting]: Okay 1994, so [indistinguishable] okay, alright, and where was, where was he born?
JOEL MILLNER: He was born in, uh, in, um, Vilna 
INTERVIEWER: Vilna, that was, that was probably in Poland at that time.
JOEL MILLNER: Yeah, it was Poland, right.
INTERVIEWER: Okay, and, uh, uh, how many, uh, uh, how many, children, were, were, did his parents have?
JOEL MILLNER: Uh, gee, that’s uh, you know I’ve never, um, uh, well they never came to this country so, uh, I knew there was a, uh, a sister and, uh, I think two other brothers, but I’m not sure. That’s a, uh, that’s a question that, uh—
INTERVIEWER: Okay, wh—, alright, what kind a, what kind of a livelihood did your grandfather have in Vilna uh, before they came over here?
[2:00]
JOEL MILLNER: Uh, well, he had some kind of a uh, of a store, but uh, I don’t think my father was involved in the store, he had learned a trade as a uh, as a uh, repairing, uh, manufacturing shoes, I thought they, they called him, he was a uh, top—, a topper, he made the uh, tops of uh, of shoes, and he had gone away to learn the trade, and uh, and then he came home, and then he was in, uh, he was, ya know, working in his trade and, and  doing very well in his trade, but I guess he was uh, 19 or uh 20 [3:00] and uh, it wasuh, he uh, left his family to uh, to come to the United States because uh, otherwise he would’ve hadda gone into the uh,service
INTERVIEWER: Now, did he go into, after, —er did he go into any separate businesses after he learned, uh, the shoe making business or he didn’t do that until he came to this country?
JOEL MILLNER: No, he did that over there, he was making a, uh, a living doing that as a young man, now, um, uh, what the family business was a, uh, I—I—I honestly don’t know.
INTERVIEWER: Okay, now, you mentioned that uh, uh, he came here to this country in 1905, uh, and he stayed with an uncle and 5 cousins.
JOEL MILLNER: Well that was, uh, uh—
[4:00]
INTERVIEWER [interrupting]: So that would have been one of his, his uh, father’s brother—
JOEL MILLNER [interrupting]: One of the father’s brothers a uh—
INTERVIEWER [interrupting]: And, where
JOEL MILLNER [continuing]: he was, uh an uncle of uh—
INTERVIEWER [interrupting]: Where did he live, when he came here?
JOEL MILLNER: Well, I thought they lived, uh, down on, uh, Unionstreet, or that area, ya know, in, in downtown uh, Trenton
INTERVIEWER: Okay, uh, do you know about how long he stayed with them?
JOEL MILLNER: He stayed with them for a short period of time, and then he moved in with uh, um, Joe Olinski[s family, and, uh—
INTERVIEWER[interrupting]: The Olinskifamily, was it Joe Olinski?
JOEL MILLNER: Yeah, I don’t know who, the, uh, the father was but, uh, you know, uh [indistinguishable], uh, I don’t remember the father’s name, I’m not sure if it was Abe or, uh, or not, I don’t know that was, you know, uh, [5:00] Joe Olinski, they, they had a roofing supply business, and, uh, and then I guess he left there and then he, I thought he worked in his trade in the Boston area for, for [indistinguishable]—
INTERVIEWER [interrupting]:O—Okay, now I have something here that I heard somewhere that he sold uh, writing papers and pens and needles, was it, did he do that while he was here in Trenton, in the Trenton Area?
JOEL MILLNER: Yeah, I—I don’t think, uh, he, ya know, he was a uh, peddler 
INTERVIEWER: okay
JOEL MILLNER: You know, uh, and—
INTERVIEWER [interrupting]: ’cause they said between 1905 and 1923 he had different businesses and he sold candy and hot dogs and—
JOEL MILLNER [interrupting]: Well, he had a little store where the guys you know, played uh, cards in the, uh, in the back room, and, uh, and he sold candy—
INTERVIEWER [interrupting]: like a, like a [indistinguishable]?
JOEL MILLNER: Yeah, yeah, but he happened to be a very good, uh, a very good [6:00] card player, now, uh, now whether he was, uh, uh made any money doing that or not uh, it’s hard to say.
INTERVIEWER [interrupting]: Well, they always, they always uh, cut the pile,, the house always cut the pile, so.
JOEL MILLNER [overlapping]: Did they really? 
INTERVIEWER: Yeah. Okay now, uh, there was a hardware store in Trenton, uh, it says five years, [indistinguishable] owned a, owned a, he had a hardware store
JOEL MILLNER: Well yeah, yeah, I guess he was on broad street, he had a, uh, houseware store, and—
INTERVIEWER: Was that Broad, uh, South Broad or North Broad, do you—?
JOEL MILLNER: I believe it was South Broad
INTERVIEWER: Okay, okay, and uh, you said that the next thing was in 1922 or 1923, uh, he bought uh, your mother a diamond ring?
[7:00]
JOEL MILLNER: Well he had, uh, well that could be, uh, you know uh, that’s probably the right—right year, I mean he had, uh, how he met my mother, or, uh, how they made the match, and, and I think it was the Rabbi who was in Trenton at that time, uh, and uh, was uh, was originally from Elizabeth, and my mother had came from a family of, uh, of ten children from Elizabeth, and I guess, uh, at that point in time she hadda be in her uh, mid to uh, mid-30’sor so, and the Rabbi knew uh, [8:00] uh, knew the family, and when my father was uh, went to state college, she realized ya know, how learned he was in, in all the Jewish uh, services, and uh, able to conduct them, and he had a uh, a beautiful Hazzan voice, and uh he thought, gee this would be a very good uh, match for uh, for Reba Jacobson, so, uh, that’s how they ma—made the match.
INTERVIEWER: and her name was Reba?
JOEL MILLNER: Reba, R—E—B—A
INTERVIEWER: Okay, and that was from, uh, they were fromwhat town was that?
JOEL MILLNER: Well, the Jacobson’s uh, were from Elizabeth, New Jersey.
INTERVIEWER: okay, okay, now they mentioned something about a car that he first owned, do you remember, uh, you said, uh, uh, [9:00] I’ve never heard of a Dwight, was that a—was that a—?
JOEL MILLNER [interrupting]: I don’t know that
INTERVIEWER: Now—
JOEL MILLNER [interrupting]: I remember he had a hotmobile
INTERVIEWER: Hotmobile?
JOEL MILLNER: Yeah, now that one seemed to be memorable, that name, because I thought it was a funny name
INTERVIEWER: Uh, it said something about his father-in -aw was in—built houses, the Jacobson [indistinguishable]—
JOEL MILLNER [interrupting]: Well, Bernard, uh, Bernard Jacobson, I guess he, uh, was in the, uh, lumber and coal business in, uh, in Elizabeth, and I guess he was there with, uh, I don’t know how many sons or, uh, were, were involved uh—
INTERVIEWER: Well, it said they had five sons and five daughters?
JOEL MILLNER: That’s right
INTERVIEWER: Okay.
JOEL MILLNER: Yeah, that’s true, [10:00] and all the, uh, I think all the sons were, uh, were in the lumber business.
INTERVIEWER: Okay, now this is the other part, another part that was, a lot of conversation took place, about taking a house in trade. What was, what was that?
JOEL MILLNER: Well, he, he was, he had, uh, what, what he did was he sold boulders, uh, he would bring in a car load of lumber and then he would tally it out and sell it off to the, uh, to the builders. And they uh, in this particular case they, they weren’t able to pay him, and that was probably during the uh, depression, and he took the uh, the house in trade, and some of the also uh [11:00] sometimes they just, that was part of the arrangement that they would supply the material and then they, and then when they would build a track of houses, and would get a house and uh, so that that would compensate them.
INTERVIEWER: [indistinguishable] says the family gave them  five thousand dollars for a wedding present, now was this in a house that hecould sell or was this a cash present
JOEL MILLNER: That was probably a cash—c—cash present that I’m sure my mother used to furnish the, uh, the house
INTERVIEWER [overlapping]: mhmm
JOEL MILLNER [continuing]:you know, because she had very expensive taste, and, uh, she didn’t, uh, [12:00] she wouldn’t settle for anything less than the best you know, uh.
INTERVIEWER:[indistinguishable]  said they loaded, loaded a truck with lumber and then he went out and sold it is that, is that what he did?
JOEL MILLNER: Well, usually they would, uh, not necessarily load a truck, but they would load off a box car to somebody else’s truck, and then what—what wasn’t sold then I guess, then he had to find uh, storage space, and, then  I guess that’s when he, he, uh, must’ve bought a, uh, um, a, um, a, uh, I guess a guy had a uh, up on Ingham avenue had a uh, a uhm, mill shop and he probably bought that, uh, I think the [13:00] family name was uh, uh, Halpert. And, uh, and then he was—it was either on Ingham avenue or Willow, I, I think it was Ingham avenue, uh, uh, and I guess he was there for a number of years and then he, he moved to uh to Prospect street and he acquired, the uh, what used to be the old globe uh, rubber mill, and he was there until, uh, well, we were there until 1941, and, uh, you know I’ve always felt that, uh, while we were there until 1941, and I always felt that, um, unbeknownst to him he was, uh, um, very instrumental in the, in changing [14:00] the, um, the uhh, the way the city was, uh, was developed in the sense that, uh, he had bought Hermi—, the uh, the uh, Hermitage avenue, uh, uh, well not the Hermitage avenue, the Prospect Street property, uh, which he was paying $125 dollars a month rent, and, and, he offered to, to uh, buy it for eighty-five hundred dollars, but that was too late,  the uh, the state or the federal government had, had bought the ground for twelve thousand five hundred dollars
INTERVIEWER [interrupting]: What, what address was that on Prospect Street? Do you recall?
JOEL MILLNER: uh, I think it was [15:00] 314 Prospect
INTERVIEWER: And what’s—what’s on that now? Do you know?
JOEL MILLNER: Well, that’s the housing, the Prospect Village is there now, see now if he had acquired that uh, uh, [indistinguishable] who knows where they would have built that type of housing.
INTERVIEWER [interrupting]: That was right, that was right where that welding place used to be?
JOEL MILLNER: across from the, uh, [indistinguishable], that uh, that came across the road and the, uh, the box cars could load right into our, uh, into our building.
INTERVIEWER: There was some—there was something about a department store in Albany, what, uh, that uh—
JOEL MILLNER: Uh, he worked for, uh, I guess it was, uh, Axel Litzer, who, uh, one time had a uh, had a store down on a, uh, on Broad Street, I—I don’t know whether they were called the [indistinguishable], I don’t know that uh—[16:00]
INTERVIEWER: Well they said it was a shirt factory. He worked in a shirt factory, and hesold everything in every department, and trimmed windows in the store.
JOEL MILLNER: Well that, I don’t know, uh, in what, I, I know that he did that, uh, and, and uh,  it had to be prior to, uh, to him getting married—
INTERVIEWER [overlapping]: alright, okay
JOEL MILLNER [continuing]:It had to have been, uh, well, he had to be uh, 1905 he came in so uh, that was like 18 years that uh, he was here in Trenton and Boston and uh, and uh, where was it, what was I sayin?
INTERVIEWER: Albany.
JOEL MILLNER: Was it Albany? Yeah uh, that was an 18 year span, you know, that uh, he, uh, was here and there and uh [17:00] he was a bachelor uh, you know, uh
INTERVIEWER: Okay, then there was something about he worked for Erkin and Kahn on Perry Street, when it was on Perry Street, right on the corner of Perry and Broad, is that where [indistinguishable] had his place there, is that? 
JOEL MILLNER: Erkin and Kahn, yeah
INTERVIEWER: Was that where it was? ‘Cause I know Erkin and Kahn was out on Clinton avenue for… 
JOEL MILLNER: Yeah, but, uh, well I don’t uh, I don’t remember uh, uh, I don’t remember that
INTERVIEWER: Which—which uncle had a junk shop on Union Street?
JOEL MILLNER: Well that had to be, uh, uh, probably the uncle that he lived with, you know, that’s, you know the person he lived with —
INTERVIEWER [overlapping]: O—Okay, okay [indistinguishable]
JOEL MILLNER [continuing]: I don’t know what his name was, but, uh that was, uh, the—the brother’s, uh, no, the sons were uh, [18:00] Frank Millner, Henry Millner, and, uh, uh, Albert Millner
INTERVIEWER: Okay and then their children, it was Irv, and, uh, Irv Millner
JOEL MILLNER: Irv Millner, was, uh, Irv was uh, was Frank’s uh,
INTERVIEWER: Son
JOEL MILLNER: Son
INTERVIEWER: Okay, well, so, so it could’ve been the Millner Family that had the junkyard, is that it?
JOEL MILLNER: Oh, it was definitely the Millner family.
INTERVIEWER: Okay, okay, alright thats, thats all  I—
JOEL MILLNER: Yeah.
INTERVIEWER: Okay, okay, now one thing that I, uh, you know, thought was a—a tremendous thing was he ordered a car load of nails? What—what was that story he was tellin? He ordered a car load of nails, and, uh, in kegs and then went out and peddled them all? 
JOEL MILLNER: Well, that waswhat he did, you know, [19:00] uh, uh, you know he would buy and, and—
INTERVIEWER: Well what got him into the wholesale business? He didn’t want to work with the Millners anymore—I mean with the uh?
JOEL MILLNER: Well he had, well, he was never really work for uh, for the Millners in the, in the, uh junkyard, no. He may have lived with them for a while, but then uh, then he peddled, he had the store on broad street and, you know, between I guess he was in Boston working in his trade.Why he left that to, uh, you know, to come back, or w—when he went to, uh, Albany, uh, I—I don’t know, you know, what the, uh, the uh, what came first, you know?
INTERVIEWER: Yes, okay, the thing is, that’s fascinating about this is that he started out ordering car loads of nails and then he had a car load of the window weights, and I remember that ’cause I used to have to fix them as a kid, so I know what he was talking about.
JOEL MILLNER: Yeah, yeah, well he, uh, he was a, uh, [20:00] um, an adventurous guy, you know he was always buying quantities of, uh, of—of material, you know, uh, he uh, I re—I— well I remember years ago now, uh, uh, he—he went and, and bought at a sale probably, uh, maybe about 1960, he bought, uh, a Mohawk Driver went out of uh business er, they were liquidating, and uh, in uh, Philadelphia, and he bought, uh, thousands of doors, you know, and, uh, that uh, well [21:00] it wasn’t this room, but uh, but one of the a—a—a similar room uh, wa—was, was filled with doors, uh from, from wall to wall, from floor to ceiling.
INTERVIEWER: When did you take over this complex here? W—When—
JOEL MILLNER [interrupting]: 1941
INTERVIEWER: 1941?
JOEL MILLNER: Yeah
INTERVIEWER: What was here before? W—Wha—
JOEL MILLNER [interrupting]: Well they manufactured school and church furniture, uh, and uh, and then I guess uh, during the depression uh, you know, that—it was a very successful, uh, uh, business, but the uh, then I think the, during the depression they wanted to work for the uh, for the people, uh, in the different, uh, states. So they, there really was, th—uh, that the school furniture would be manufactured within the state, [22:00] not in—in, uh, in Trenton.
INTERVIEWER: Ho—How old is this building? Because wooden beams that you have here
JOEL MILLNER: This, uh, this has to be a hundred years old I would think, or uh close to it.
SPEAKER 3: [indistinguishable] Gonna get a quick bite
JOEL MILLNER: Well why don’t you wait until I’m done with uh, this oral, because uh, you know he’s, uh, not gonna be, uh—
INTERVIEWER: No, it won’t be that much longer, just a little bit
JOEL MILLNER: uh, and we uh, uh, in fact, uh, he, they had a s—sale here, when they sold out, and you can’t believe the desk that he bought.
INTERVIEWER: In all the time, are there any of those things still left in here, the old window sashes, [indistinguishable], old doors, old desks? [23:00]They long gone?
23:00
JOEL MILLNER: Oh, I don’t know, you know, there’s probably, ha, there’s probably still some window weights around, you know, in fact there are, you know, window weights around uh, uh, there’s some old uh, uh, moldings, that uh, Chestnut moldings, that uh, ya know, that ceased to be a going thing, uh, you know uh, where they used back pans and stuff, uh, you know, uh, eh back to, I don’t know I just sold a guy 13 pair of sash that uh, that would, have to go back to the uh, 1950s, you know, when we bought ’em.
INTERVIEWER: Well if you could—
JOEL MILLNER [interrupting]: I was in college, I was in college when those windows were bought
INTERVIEWER: If you come across any stuff that has your name [24:00] on it or Millner Lumber that goes back in old letterheads, or a photograph of a building or the workers, I mean—I’d like to have that for the archives, if you come across it, you know,[indistinguishable]—
JOEL MILLNER [overlapping]: I doubt it
INTERVIEWER [continuing]: Well, if you do you know not to throw it away, alright, so save it for me.
JOEL MILLNER: Well, I wouldn’t throw it away, yeah, uh
INTERVIEWER: When—When did, uh, uh, you and your brother take over here, when—when did you both come to work here?
JOEL MILLNER: uh, I would think that probably 1952, uh—
INTERVIEWER: Was your sister active at all here?
JOEL MILLNER: My sister was never, never, never worked here,my brother and I you know, started working here uh, when we were twelve years old. That’s why I tell people I‘ve been working around here 55 years uh
INTERVIEWER: That’s when we all started, about that age. 
JOEL MILLNER: Yeah [laughing], you know, uh, uh and, in those days it was uh, [25:00] hard work you know, they didn’t have the mechanical equipment that they have today, you know, for unloading, and we used to get up, uh, you know, come to work 6 o’clock in the morning and sometimes work ‘til 6:30,7:00 at night, you know, was, uh, stuff had to be, uh, loaded and shipped and what not, uh
INTERVIEWER: Do you remember what the first trucks were that were in here that you were able to—that you were permitted to drive?
JOEL MILLNER: Oh, well that was a, uh, well I picked up the, uh, I was a, uh, driving trucks before I was permitted to drive, you know uh, I remember I guess it must’ve been, uh, must’ve been 1941 or so, you know, uh, I went over and took one of the trucks out of the garage on a Sunday, and uh and drove it up to uh, [26:00] Slocums Bowling Alley and uh, on Pennington Road, and we were bowling and didn’t have a license, and uh, and uh on the way back we ran out of gas, and because there were no gas stations open because they had gas rationing, and what not, and uh, so uh, well I was with two other fellas, and I said well [indistinguishable]do is go back and get the other truck and tow it back to uh, to the uh, yard. So, uh, whichever we did, we had to take the bus back to Prospect Street from Pennington Road, I brought the other truck up and we started to tow it back and we you know, came down Parkside Avenue, made the turn going up Oakland Street, and uh, somewhere [27:00] along the line something happened to one of the uh, to the uh, break on the truck that was being towed, and we, uh, we got to corner of Prospect and, uh, Oakland and Prospect and I, ya know, stopped the uh, uh, stopped the truck to make the turn and all of a sudden “BOOM”, the car comes in and crashes the whole uh, headlight and fender. So, uh, I said, “oh this isn’t very goo—not very good, what are we gonna do about this?” And I said, “well we still have to take the truck down Prospect Street and take it around the back of the, uh, building where it gets parked”, and I said “now, look, when we, when we, when I signal that I’m stopping, you know, turn the, uh, truck away, so that we, the truck wont hit the back of the, um, the tow truck won’t hit the back of the truck we got”, [28:00] and okay, I wave, and he’s supposed to pull away and all of a sudden “BOOM” got the other fender, and uh, headlight, and, but I don’t know, I think the charge to have it repaired was like $300 dollars but I paid it back, uhhm, but uh, that was, uh, you know, that’s when I was driving, you know, um you know, must’ve been—
INTERVIEWER [interrupting]: Did they ever have, did Millner Lumber every have a horse drawn?
JOEL MILLNER: I think originally yeah, he,he did, you know, yeah.
INTERVIEWER: Are there any pictures of—of that ar—ar—around?
JOEL MILLNER: No, no, and I think we used to, originally, um, o—one of the trucks, you know, yo—you had to crank it to uhh, uh, to start it.
INTERVIEWER: ‘cause we came across some of shines trucks with a horse wagon, and then  som—another truck.
JOEL MILLNER: Yea, yeah, no [29:00] I don’t believe we have any pictures of that, but uh
INTERVIEWER: So, when did your dad actually retire from here and went to Florida, and didn’t, and didn’t—
JOEL MILLNER [interrupting]: Well, I don’t think he ever really retired, you know, uh, uh, I, you know, when we came into the business, and—and probably wrongly so, in 1952, you know, we were both here, when I was at—finished college, [indistinguishable] was here uh, you know, while I was in, in college, and he decided he didn’t want to go to college, er uh, and, uh, my father pretty much backed off, you know, from uh, being an active participant, he wanted to be a participant, but uh he, he, he, he didn’t want the, the daily uhh, problems, that uh, ya know, the servicing the customers uh, that uh, that uh, were required, ya know. [30:00] I mean, he wanted to make the decisions, but he wasn’t around, you know, to uh, to uh, to make the decisions, and uh, we found it necessary to make the decisions, and then have him, you know, uh, uh, say well you shouldn’t have done this or you shouldn’t of done that. Well, listen we had to make a decision and that’s the decision we, you know, we, we, we made, uh, you know, if you wanna, if you’re here then we’ll consult you, but if you’re not here i feel you have to give us the, uh that we’re, we’re attempting to do the best job possible, but, you know. So that’s when uh, uh, he sort of backed off and then I think he was, when he moved to Florida uh, he was 84 years old, so he lived in Florida almost 20 years, uh, I—I think, uh, into his 90s [31:00] he came back and he had the home on uh, on Bellevue Avenue and he, he had a place to stay, and after that, he uh, he came, after he sold the house he came back, but, but less uh, frequently, because then he would stay with a friend, uh, Andrew Repaul, and, uh, occasionally he would stay with us, but I don’t think he was comfortable staying with us, you know, because you’re always, you’re not home, you’re going, you’re coming, you know, I don’t know, I can’t eat the hours that you guys eat, you know, and uh, and uh, and then he, uh, and then he stayed with a fellow by the name of Lou Bellanchio, that had, uh, uh, that had a furniture factory, that, that he was manufacturing furniture, [32:00] uh, sofa beds. Uh, do you remember he, uh, well originally he was on, uh, I—I guess he, he was, he manufactured in the old Skillman building— 
INTERVIEWER: Oh yeah, yeah.
JOEL MILLNER: Ya know? And then he moved up to Adams Avenue, and then he moved back here, and, and was here for a number of years, and then I guess uh,, ya know uh, they went out of business, uh
INTERVIEWER: Now, did you own, or your dad own your [indistinguishable] or was that the [indistinguishable]?
JOEL MILLNER: [indistinguishable]—
INTERVIEWER [interrupting]: Pkay, and on this side of the street, where the back is, did you own that spot?
JOEL MILLNER: No, that was, uh, that was the, uh,  uh, Johnson Oldsmobile.
INTERVIEWER: Well, wasn’t Stanley Products in there?
JOEL MILLNER: Well, Stanley Products moved in after Johnson left.P
INTERVIEWER: okay, alright. 
JOEL MILLNER: You know, [33:00] and then the bank took it over, ya know, and, and we were probably uhh, uh, negligent in, in not attempting to, to buy that and, and utilizing that as a front, storefront with the yard in the, in the, in the back, but, you know, we had so much space here that, uh, and, uh, it wasn’t as important to, uh, uh, t—to be uh, fronting on Hermitage Avenue, uh, at the point in time, you know, or we could, uh, have acquired, uh there was a gas station o—on the corner here uh, you know, and then the bank, uh, put a little branch in th—in there and uh, between the gas station and our property. 
INTERVIEWER: That was, that was Gale, over that gas station, didn’t he—guy by name of Gale? He had a Pontiac [indistinguishable]  
JOEL MILLNER [interrupting]: It could be,  I never noti—
INTERVIEWER [Continuing]: [Indistinguishable] Young fella, I remember a guy, it was a young fella. 
JOEL MILLNER: Well, who was that, [34:00] I thought it was—the one guy that had it was by the name of Alan, wasn’t it?Uh, I don’t remember his first name—
INTERVIEWER: Because across the street was Ross, wasn’t it?
JOEL MILLNER: Burt Ross, uh Burt and Laura Ross
INTERVIEWER [overlapping]: Burt Ross, yeah.
JOEL MILLNER [continuing]: Yeah, yeah, and then, uh, next to it was Weinstein, and then, uh, I think Kunis had a, little, uh, bakery there?
INTERVIEWER: There was a bakery, a laundromat, Hermitage Press was in there, the printers [indistinguishable]
JOEL MILLNER: Yeah, and uh, Kramer, the uh, the uh, tailor was there—
INTERVIEWER: [overlapping]: yeah, [indistinguishable]
JOEL MILLNER [continuing]: A—And then Prior Donuts was there, uh, and then at one time, they had a little restaurant on the uh, corner of, uh, Hermitage and uh, and Edgewood uh, ya know, it wasn’t a bad little, uh, restaurant.
INTERVIEWER: I remember, I think it was a pizza shop there. Okay, well I tell ya that will, that will certainly fill in—');

INSERT INTO TRANSCRIPT(Transcript_ID, Transcript_text)
VALUES ('003', 'ORAL HISTORY WITH DR. PAUL LOSER- 1976-08-12
Soundfile Names: https://archive.org/details/OralHistroyWithDr.PaulLoserSideA
https://archive.org/details/OralHistroyWithDr.PaulLoserSideA/Oral+Histroy+with+Dr.+Paul+Loser+-+side+B_blank.mp3
Interviewer: Harold Perry
Interview Date:12 August 1976 
INTERVIEWER: ….Interview with Dr. Paul Loser. Distinguished educator, and longtime super intendent for Trenton public schools. This is tape one, track one for this interview.
 
[interview begins]
 
INTERVIEWER: Dr. Loser, we’d like to record here uh, your Trenton recollections, uh your comments on growth and development of education in this area. 
LOSER: My first contact with Trenton and Trenton public schools came in 1916. When I arrived in town I was a teacher of mathematics, and an assistant coach to the football team. Uh, after serving in the army and spending additional years in Trenton, I went to Plainfield, and came back as Vice Principle of High School in 1922. At that time, there were 2,000 pupils in the High School, and they were housed in the old High School building which had a capacity of 700. And another school, an elementary school within that and also another school. So we had a pretty big set up, 2,000 pupils on double setting. And that condition existed until about 1924 at which time Jr. King was open and the tenth grade of the entire city was moved to the Junior High School which was located on Parkside. The next step [2:00] was the completion of a Senior High School. And I had nothing to do with the planning of that building but it was, in my opinion, one of the best planned high school buildings in the united states. Dr. Westford was a very capable administrator, had a dedicated group of teachers who would spend hours and days planning and the results for that building still, it was nice to have a new building and the building was very adaptable. [2:30] Now uh, later, in 1932 upon the Death of Dr. Wicken, I became superintendent of schools. It was the beginning of the depression, and to sum that as far as the schools were concerned,   teachers took a twenty percent cut in salary, and I eliminated home economics [3:00] and the mantal arts for the elementary school. And I continued that way until things began to get better, and that was the start of the PWA. That’s the Public Works Administration, different from the WPA.  Public Works Administration was some of the younger people [3:30] who, uh if you’ve never heard of it, operated for the benefit of skilled mechanics. And we put in an application for federal aid and with that we got enough money to erect five schools in Trenton. The new Washington school, the Parker school, the Junior Highschool number two, [4:00] in addition to what is now Junior five, and uh, I forget the name of the fifth one [chuckles] but we had five school buildings added in that time. Now our thought, we thought of a system, thought was, that uh, we should make a school in preparation for instruction and training of the children of all variations, such as physical variations. I’m thinking now hard of hearing, the children with poor vision, I’m thinking of uh, crippled children. And when our Junior High School number two became a model, many school buildings around the state had been included in it. [5:00] in that it had a separate room for… we had a crippled children’s room, where we transferred by bus crippled children from all over the city, with a ramp and ramps in school buildings which was very unique during those days because everything was steps. So we had ramps leading up from a  bus loading platform [5:30] to entering the school. We also included in that building an elementary division. So the children from the eastern section town around to Cook Avenue were kindergarten through ninth grade in that building, and it worked out very well. And we did at that time, we continued at that time, classes for children who were retarded … mal-adjusted children, we established what we call adjustment classes in a number of schools, where we would take children who were problem children and needed more specific attention than they could get in a class, an elementary classroom with thirty, thirty-two children. We put these adjustment classes in various areas of various buildings and [6:30] and in that we set up programs that were based on mechanical. A lot of these children could learn how to do things with their hands, where as they us, they weren’t so built that they could absorb academic information really. Now we thought we were accomplishing something there. Since that time, [7:00] with the last twenty years that I’ve been out of the system, there has been quite a change in the makeup of a school population in Trenton. The number of non-whites has uh, increased tremendously. And non-whites include very many children from large families, from a very low economic background they’re coming. [7:30] And they are children who need particular attention in order to circumvent some of the circumstances and conditions under which they live. I think the system, the school system, has been working hard at developing the individual child. It’s a tremendous undertaking, needs dedicated and well trained and capable teachers, and it needs the support [8:00] of the parents of the children in school as well as the support of the community.  I think the Trenton community as a whole has supported its schools quite well. But programs such as being operated and as being contemplated, as read in the newspapers, is going to require additional support [8:30] and understanding on the part of the parents and of other people as to what the school is trying to do with children at the present time. It’s a difficult undertaking, and its uh, you can’t tell, it’s one of these things you can’t see the results of in one year, or two years. It’s a long drawn out proposition. Some of these children need three years for training before they may, and it’s not only non-white children there are some white children in the same group, need three years of training under certain teachers in order that they [9:00] may adapt themselves to the circumstances and become, become the kind of citizens that adults would like their children to become. I think that, again from what I read, that the programs that come to play in Trenton has become as advanced as any other I had ever heard of. And the thing to do is go along with the programs [9:30] and try to see what results come from this adaptation of school. Now that’s a long speech I tried to [overlap] 
INTERVIEWER: But it’s very interesting. I wonder if the very political aspects in the city had any particular impact on the picture of education as you, as you’ve experienced it.
LOSER: Well, we’ve had the mayor and cops there, we’ve had management type [10:00] we’ve had various things.
INTERVIEWER: What affect does that have on school administration?
LOSER: Uh, that’s a good question. When I became Super Intendant, Fred Donelly was Mayor, and Fred Donelly wanted a good board of education. And it was the appointed board, rather than the elected board in my experience. The mayor uh, the board had consisted of a number, now I don’t want to start with names because I’ll forget some and that wouldn’t be fair, but the board as a whole was a group of citizens interested in the welfare of schools, and not interested in politics. I can say truthfully I worked under eight mayors, and only one tried to inject politics in the school system. The others, if a vacancy occurred [11:00] a number of times I’ve been contacted by the Mayor’s office with a remark like this. They’d say “Paul, let’s find. Good person to go on the board. And that’s true. And that made for, uh, that made for good boards, non-political boards. Now I’d like to break over to something else that came with that board. [11:30] The Super Intendant of schools was the chief executive officer of the school. All employees were responsible to the board of education through the Super Intendent of the schools with the exception of the secretary of the board, who evidently handled all financial matters. The Super Intendant of Supplies, the Super Intendent of Building and Grounds, The Medical Director, the Cafeteria Director all had to report [12:00] to the board, when reports were called for, through the Super Intendant of schools. So I considered it my job to select the best people available for vacancies, based on professional experience, training, and so on. If I selected the wrong people, then the board should select another Super Intendant. We had a working not written, we had an understanding that they had elected me to pay attention to the details [12:30] and make a recommendation and bring them up to date. And it was an almost ideal situation. Now since my time, and I had nothing to do with it, but since my time I have seen more evidences of politics creeping out of the board’s actions. And uh, not all bad, but there are a lot of things that, in my professional opinion [13:00]  were not good for the welfare of the community. And that’s my only concern with that.
INTERVIEWER: Now you mentioned that you came to Trenton in 1916?
LOSER: Yes.
INTERVIEWER: Would you like to say anything about what the city was like then and how its changed? In the layout, and aspect, and activities, and entertainment, and churches, and all of that sort of thing?
LOSER: Well okay I’d like to start with something [13:30] I’ve told a number of times, and to me it’s indicative of what, of some of the things that were going on in the city. There was one time just before Labor Day in sixteen and I picked up a copy of the Trenton Times. On the front page, there was a photograph of a check signed by James Carney for six cents to John A. Rogan. [14:00] [both laughing] He had lost the Bible’s loot, you must appreciate that. [laughs] For me it was the indication of what we have here of two strong men and the battle to earn the [inaudible] and the long following success, alright? And it was a spirit, and that was part of it. There were, I shouldn’t be saying this but there were a number of men [14:30] in power in Trenton that were looking for the welfare of the city and working for the welfare of the city. And uh, we had, uh we had pretty solid church attendance in those days, I can remember that. seeing people going to church and uh seeing people going to the church that I, that I attended . There was much more, well bigger church attendance than there is percentage wise [15:00] right now. We had our mixture of uh, various immigrants from European cities. But, while they held to a certain extent the customs of their home towns, they didn’t do that over or above what they were doing for the United States. I, we knew a number of them from these activities, community activities, church activities, but after all, [15:30] they realized that they were a part of something bigger, and they were not the outlet to be catered to, as some groups do, but they retained some of their ethnic traditions, like Italians or Asians [overlap] 
INTERVIEWER: Yes, that’s what I’d think
LOSER: like the Feast of Lights [overlap]
INTERVIEWER: So it was moderate? [overlap]
LOSER: But they were American. Um yes, I think it was moderate. They were Americans though. [16:00] And well uh, you know them, you know of these men, and I know a number of them, there were a lot of men in the city, and around it also, that worked solely for the benefit of their community as a part of their whole state. I can think of a number of women who were active in the Parent-Teacher Associations. And they weren’t working, for uh, self-publicity. [16:30]They were working for the school in which they represented, the community. We had a lot of prominent and very important women in the Trenton community.
INTERVIEWER: Oh? [overlap]
LOSER: Annie Feemers, 
INTERVIEWER: Yeah, [overlap]
LOSER: Sarah Christie, Sarah Asktee, and uh talking about one Mrs. John Curney.
INTERVIEWER: Yes.
LOSER: And Mrs. Tom Curney. She was very active during the war. [17:00] And uh, in various – she went to go on to pick up twenty-five to fifty nights. Outstanding people! Who were selfless, who were working hard-
INTERVIEWER: It made a lot of difference to Trenton.
LOSER: It certainly did. They weren’t always scrawling, scrapping between sections. I was talking to Dr. Elizabeth McDowell the other day, a matter of fact we made a tape, and she was talking about how excited she was when she came to Trenton, what a wonderful place she thought it was, which was very refreshing.
INTERVIEWER: Yeah?
LOSER: Sure. Who you kidding? I came down the Pennsylvania railroad, crossing the Delaware River, [17:30] Trenton takes, uh Trenton makes the world takes, and I think yea sure that’s a good place. And uh, I arrived here, as I told you, as an assistant football coach and at that time, in the place where Junior King now stands was YMCA athletic field. And uh, [18:00] that was the year that we um, oh we had the epidemic uh, 
INTERVIEWER: Flu?
LOSER: No not the Flu, the paralyzing disease,
INTERVIEWER: Polio?
LOSER: Yes, yes polio. The polio epidemic in sixteen. It’d end up in the schools for a month. And we had these boys out practicing football however they couldn’t go out on the athletic field, but we could take them out on the playing field. [18:30] And these kids would come out and they were good regular kids you know. I want to say something about that. From three and a half years, yes for three and a half years when I came back to Trenton I was Vice Principal of high school and we were working under, I told you, those pretty horrible conditions. Then for five years I was out here at Junior King for Principal. And that makes nine years in which I was a chief. [19:00] Out here they call that security office, uh chief disciplinary office in the school. And um, we had some discipline trouble but, If I caught a youngster doing something that he shouldn’t have been doing that was bad and I gave him the punishment for it, if he knew [19:30] and I had to talk to him and give him a punishment, he’d accept it. He’d say well I did that and therefor I had it coming to me. And I don’t see that attitude today. We couldn’t get away with it now.
INTERVIEWER: No?!
LOSER: The kids back then were awfully fair as long as they felt that they were being fairly treated. [20:00] And we didn’t have kids saying they’d burn down somebody’s house just because he was disciplined the day before in school or anything like that, you know? I noticed to my sorrow a change in the attitude of the people. Because those kids who I am talking about are in my opinion regular, who would stand up and take punishment as long as they felt they had it coming to them. Most of the time they did. So, then the YMCA had two big organizations [20:30] going on at that time. The one down town and the Cook YMCA. I lived at the Cook YMCA my first year and I lived at the dormitories there. I’d seen the benefit that those institutions had on the community. And there were boys clubs, different types than our organized boys clubs which incidentally I think is a schools job. But um, [21:00] they had these organizations working for one thing and that was just to increase the moral standards of the community, and to give these students something really in their lives enjoy. I don’t uh, there is a lot you could talk about as far [21:30] with this but to get over the pedicle thing of the phase uh I just don’t want, uh there shouldn’t be shame in why it had to be discontinued and torn down. 
INTERVIEWER: What was the reason for that?
LOSER: It was my understanding that uh, that was a part, that was a segment of a donation and one of the provisions in the grant was that the building should be used for YMCA purposes only. To not be used for anything else. And there was no more YMCA there, [22:00] the building was deteriorating so the only thing to do was to tear it down. That was a Cook grant, you know. That did serve a real purpose. 
INTERVIEWER: [overlap] Yeah that’s true.
LOSER: It served a tremendous purpose there. It had Al Back, who was well known among the sporting community in the town. 
INTERVIEWER: Mhm.
LOSER: A good ex-potter who was a good athlete who was working for boys out there, and he did a marvelous job. I hope the kids got a lot out of, I mean they had a generally good [22:30] athletic program. What about the growth and change in Trenton? There’s been quite a lot of change in some important industries that moved out and some that remained and stayed important. And that’s really sad. Once you take Trenton potters you take Rollinngs, two of the big ones. The [23:00] people who made the tire making machine, uh, the Throfts! and that uh, all of the rubber plants, Madix Pottery, and oh! Uh between this mentioned Questish Pottery went out of business and it has made a difference tremendously! Because in the town mechanics yes, because I don’t know what the [23:30] total number of mechanically, uh mechanical workers I’m thinking plants uh like General Motors out here, uh how many plants are around town or how many people are applying, when you take a plant like Rollings out of it, you are leaving people who will have to earn their living by [24:00] either by working by working in a service industry or working in government. So, that’s about what it is. 
INTERVIEWER: Well state government has made a lot of difference 
LOSER: [overlap] oh yes!
INTERVIEWER: in population and the rate of growth and success in business. 
LOSER: [overlap] Yes, well that’s sort of what is come to it. Community allows it. We take those buildings out of there [inaudible] and that would be a tremendous benefit. 
INTERVIEWER: What about the changes in the layout of the city, and all of the and all one-way streets and additional buildings you’ve seen since you came? 
LOSER: There’s been a lot of that. All tremendous buildings [24:30] like royal’s new,
INTERVIEWER: all of memorial’s new
LOSER: and all those state, all of those state phone and operated buildings down their , um 
INTERVIEWER: the apartment residences up there
LOSER: and um if you take West Stacy from the capital out to Callon see what happens. 
INTERVIEWER: Sure.
LOSER: Uh, and, [25:00] the, so there’s a pretty big ghetto district scattered around, that’s one that one we’d like to reevaluate. Poor houses, poor living facilities, and that’s not going to the absentee landlord, is it? and that’s part of the ball game.
INTERVIEWER: Sure is. 
LOSER: and uh, it isn’t only in the poor houses. [laughs] I know some [25:30] apartment houses where they actually keep [inaudible, laughing]. 
INTERVIEWER: Right, exactly. 
LOSER: No, I have liked Trenton. We’ve been very happy here, and the town has been good to me. I liked it, I was going to say, I learned to know a lot of very very fine people. And so, I’ve lived here, in September, I’ll have lived here for sixty years. [laughs] [26:00]
INTERVIEWER: Well thank you very much for this sir. The information has been fascinating, and I am sure it will be very useful as a historical record. 
LOSER: Well,
INTERVIEWER: [interrupts] When we get this transcribed I will submit a copy to you, if I ever do get it transcribed.
LOSER: Thanks for listening.
INTERVIEWER: I can’t wait to listen.
LOSER: I think I talked a little too much.
INTERVIEWER: No, not at all. 
LOSER: I really meant what I said when I said I liked Trenton.
INTERVIEWER: Well thank you very much.
            [end of interview]');


INSERT INTO HAS_TRANSCRIPT(Transcript_ID, Recording_title)
VALUES ('001', 'Finkle, Herman "Humpsy"');

INSERT INTO HAS_TRANSCRIPT(Transcript_ID, Recording_title)
VALUES ('002', 'Millner, Joel');

INSERT INTO HAS_TRANSCRIPT(Transcript_ID, Recording_title)
VALUES ('003', 'Dr. Paul Loser');

CREATE EXTENSION pg_trgm;
CREATE INDEX recording_title_trigram ON RECORDING
USING gist (Recording_title gist_trgm_ops);

/*Views*/

/*Views for Filter*/

/*Topic and Category Filtering View*/
CREATE VIEW RECORDING_TOPIC AS
SELECT *
FROM RECORDING
NATURAL JOIN TOPIC_OR_CATEGORY;

/*Nationality Filtering Views*/
CREATE VIEW RECORDING_INTERVIEW AS
SELECT *
FROM RECORDING
NATURAL JOIN INTERVIEW_WITH;

CREATE VIEW RECORDING_SPEAKER AS
SELECT *
FROM RECORDING_INTERVIEW
NATURAL JOIN SPEAKER;

/*Views for Superuser Transactions*/

/*Views for Getting All Attributes*/
CREATE VIEW SEL AS
SELECT *
FROM RECORDING;

CREATE VIEW REC_INTERVIEW AS
SELECT * 
FROM SEL
NATURAL JOIN INTERVIEW_WITH;

CREATE VIEW REC_HASTRANS AS
SELECT *
FROM SEL
NATURAL JOIN HAS_TRANSCRIPT;

/*\i transactions.sql*/

/*
\o tables.txt
SELECT * FROM RECORDING;
SELECT * FROM SPEAKER;
SELECT * FROM INTERVIEW_WITH;
SELECT * FROM TRANSCRIPT;
SELECT * FROM HAS_TRANSCRIPT;
SELECT * FROM TOPIC_OR_CATEGORY;
SELECT * FROM SUPERUSER;
\o
*/
