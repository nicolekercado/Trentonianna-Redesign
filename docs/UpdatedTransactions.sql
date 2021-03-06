/*NOTE: Our search transaction requires the creation of the extension pg_trgm so 
the search requires the role of superuser to work */

/*All of these transactions use example data values*/

/*User Transactions*/
/*=================*/

/*Play a Recording*/
SELECT Audio_file
FROM RECORDING
WHERE Recording_title = 'Dr. Paul Loser';

/*Display a transcript*/
/*NOTE: The output of this transaction is written to a file 
because the output of it is the transcript text (as a string), 
which is so long that it looks bizarre in the terminal.*/
CREATE VIEW SEL AS
SELECT *
FROM RECORDING
WHERE Recording_title = 'Millner, Joel';


\o out.txt
SELECT Transcript_text
FROM REC_HASTRANS
NATURAL JOIN TRANSCRIPT;
\o


/*Display description*/
SELECT Description, Publication_date, Year_recorded
FROM RECORDING
WHERE Recording_title = 'Finkle, Herman "Humpsy"';

/*Filter recordings based on Topics/Categories*/
SELECT Recording_title
FROM RECORDING_TOPIC
WHERE Topic_or_category_name = 'World War II' OR Topic_or_category_name = 'Education';


/*Filter recordings based on the year the recording was recorded*/
SELECT Recording_title
FROM RECORDING
WHERE Year_recorded = 1995 OR Year_recorded = 2003;

/*Filter recordings based on whether a Family Business is mentioned in the recording*/
SELECT Recording_title
FROM RECORDING
WHERE Family_Business = TRUE;

/*Filter recordings based on the nationality of the speaker(s)*/
SELECT Recording_title
FROM RECORDING_SPEAKER
WHERE Nationality = 'Polish';


/*Filter recordings based on whether or not the speaker(s) is Jewish*/
SELECT Recording_title
FROM RECORDING_SPEAKER
WHERE Is_jewish = TRUE;


/*Filter recordings based on gender of the speaker(s)*/
SELECT Recording_title
FROM RECORDING_SPEAKER
WHERE Gender = 'Male';

/*Search based on recording title*/
SELECT Recording_title
FROM RECORDING
WHERE Recording_title % 'Milmner';

/*Superuser Transactions*/
/*======================*/
/*Log in and out of the system*/
SELECT Username
FROM SUPERUSER
WHERE Username = 'Username123' AND Password = 'Password123';

/*Display a recording???s attributes and its corresponding speakers and transcript and their attributes as well*/
/*NOTE: The output of this transaction is written to a file 
because the output of it is so long that it's difficult to decipher in the terminal*/
CREATE VIEW SEL AS
SELECT *
FROM RECORDING
WHERE Recording_title = 'Dr. Paul Loser';

\o all_attributes.txt
SELECT *
FROM SEL;

SELECT Speaker_number, Name, Gender, Nationality, Is_jewish
FROM REC_INTERVIEW
NATURAL JOIN SPEAKER;

SELECT Transcript_ID, Transcript_text
FROM REC_HASTRANS
NATURAL JOIN TRANSCRIPT;
\o

/*Delete a transcript*/
DELETE FROM TRANSCRIPT
WHERE Transcript_ID = '002';

/*Delete a speaker*/
DELETE FROM SPEAKER
WHERE Speaker_number = 3;

/*Delete a recording*/
DELETE FROM RECORDING
WHERE Recording_title = 'Millner, Joel';

/*Add a recording*/
INSERT INTO RECORDING (Recording_title, Audio_file, Interviewer_name, Year_recorded, Publication_date, Family_business, Description)
VALUES('Millner, Joel', 'https://archive.org/details/JHS13SideA', 'Not Mentioned', 1995, '1995-05-31', TRUE, 'JHS 13 31 May 1995 Joel Millner, at his office Millner Lumber Side A: Largely a discussion of the Millner family genealogy and ancestors. His father Nathan was born in the 1880s and the family lived in Elizabeth, N.J. before moving to Trenton. He worked as a businessman for many years and passed the family tradition of entrepreneurship to his sons and grandsons. Side B: Blank.');

/*Add a Speaker*/
INSERT INTO SPEAKER (Name, Gender, Nationality, Is_jewish)
VALUES ('Joel Millner', 'Male', 'Polish', TRUE);

INSERT INTO INTERVIEW_WITH(Recording_title, Speaker_number)
VALUES ('Millner, Joel', (
SELECT Speaker_number
FROM SPEAKER
WHERE Name = 'Joel Millner'
));

/*Add a transcript*/
INSERT INTO TRANSCRIPT(Transcript_ID, Transcript_text)
VALUES ('002', 'ORAL HISTORY WITH DR. PAUL LOSER- 1976-08-12\nSoundfile Names: https://archive.org/details/OralHistroyWithDr.PaulLoserSideA\nhttps://archive.org/details/OralHistroyWithDr.PaulLoserSideA/Oral+Histroy+with+Dr.+Paul+Loser+-+side+B_blank.mp3\nInterviewer: Harold Perry\nInterview Date:12 August 1976 \nINTERVIEWER: ???.Interview with Dr. Paul Loser. Distinguished educator, and longtime super intendent for Trenton public schools. This is tape one, track one for this interview.\n \n[interview begins]\n \nINTERVIEWER: Dr. Loser, we''d like to record here uh, your Trenton recollections, uh your comments on growth and development of education in this area. \nLOSER: My first contact with Trenton and Trenton public schools came in 1916. When I arrived in town I was a teacher of mathematics, and an assistant coach to the football team. Uh, after serving in the army and spending additional years in Trenton, I went to Plainfield, and came back as Vice Principle of High School in 1922. At that time, there were 2,000 pupils in the High School, and they were housed in the old High School building which had a capacity of 700. And another school, an elementary school within that and also another school. So we had a pretty big set up, 2,000 pupils on double setting. And that condition existed until about 1924 at which time Jr. King was open and the tenth grade of the entire city was moved to the Junior High School which was located on Parkside. The next step [2:00] was the completion of a Senior High School. And I had nothing to do with the planning of that building but it was, in my opinion, one of the best planned high school buildings in the united states. Dr. Westford was a very capable administrator, had a dedicated group of teachers who would spend hours and days planning and the results for that building still, it was nice to have a new building and the building was very adaptable. [2:30] Now uh, later, in 1932 upon the Death of Dr. Wicken, I became superintendent of schools. It was the beginning of the depression, and to sum that as far as the schools were concerned,   teachers took a twenty percent cut in salary, and I eliminated home economics [3:00] and the mantal arts for the elementary school. And I continued that way until things began to get better, and that was the start of the PWA. That''s the Public Works Administration, different from the WPA.  Public Works Administration was some of the younger people [3:30] who, uh if you''ve never heard of it, operated for the benefit of skilled mechanics. And we put in an application for federal aid and with that we got enough money to erect five schools in Trenton. The new Washington school, the Parker school, the Junior Highschool number two, [4:00] in addition to what is now Junior five, and uh, I forget the name of the fifth one [chuckles] but we had five school buildings added in that time. Now our thought, we thought of a system, thought was, that uh, we should make a school in preparation for instruction and training of the children of all variations, such as physical variations. I''m thinking now hard of hearing, the children with poor vision, I''m thinking of uh, crippled children. And when our Junior High School number two became a model, many school buildings around the state had been included in it. [5:00] in that it had a separate room for??? we had a crippled children''s room, where we transferred by bus crippled children from all over the city, with a ramp and ramps in school buildings which was very unique during those days because everything was steps. So we had ramps leading up from a  bus loading platform [5:30] to entering the school. We also included in that building an elementary division. So the children from the eastern section town around to Cook Avenue were kindergarten through ninth grade in that building, and it worked out very well. And we did at that time, we continued at that time, classes for children who were retarded ??? mal-adjusted children, we established what we call adjustment classes in a number of schools, where we would take children who were problem children and needed more specific attention than they could get in a class, an elementary classroom with thirty, thirty-two children. We put these adjustment classes in various areas of various buildings and [6:30] and in that we set up programs that were based on mechanical. A lot of these children could learn how to do things with their hands, where as they us, they weren''t so built that they could absorb academic information really. Now we thought we were accomplishing something there. Since that time, [7:00] with the last twenty years that I''ve been out of the system, there has been quite a change in the makeup of a school population in Trenton. The number of non-whites has uh, increased tremendously. And non-whites include very many children from large families, from a very low economic background they''re coming. [7:30] And they are children who need particular attention in order to circumvent some of the circumstances and conditions under which they live. I think the system, the school system, has been working hard at developing the individual child. It''s a tremendous undertaking, needs dedicated and well trained and capable teachers, and it needs the support [8:00] of the parents of the children in school as well as the support of the community.  I think the Trenton community as a whole has supported its schools quite well. But programs such as being operated and as being contemplated, as read in the newspapers, is going to require additional support [8:30] and understanding on the part of the parents and of other people as to what the school is trying to do with children at the present time. It''s a difficult undertaking, and its uh, you can''t tell, it''s one of these things you can''t see the results of in one year, or two years. It''s a long drawn out proposition. Some of these children need three years for training before they may, and it''s not only non-white children there are some white children in the same group, need three years of training under certain teachers in order that they [9:00] may adapt themselves to the circumstances and become, become the kind of citizens that adults would like their children to become. I think that, again from what I read, that the programs that come to play in Trenton has become as advanced as any other I had ever heard of. And the thing to do is go along with the programs [9:30] and try to see what results come from this adaptation of school. Now that''s a long speech I tried to [overlap] \nINTERVIEWER: But it''s very interesting. I wonder if the very political aspects in the city had any particular impact on the picture of education as you, as you''ve experienced it.\nLOSER: Well, we''ve had the mayor and cops there, we''ve had management type [10:00] we''ve had various things.\nINTERVIEWER: What affect does that have on school administration?\nLOSER: Uh, that''s a good question. When I became Super Intendant, Fred Donelly was Mayor, and Fred Donelly wanted a good board of education. And it was the appointed board, rather than the elected board in my experience. The mayor uh, the board had consisted of a number, now I don''t want to start with names because I''ll forget some and that wouldn''t be fair, but the board as a whole was a group of citizens interested in the welfare of schools, and not interested in politics. I can say truthfully I worked under eight mayors, and only one tried to inject politics in the school system. The others, if a vacancy occurred [11:00] a number of times I''ve been contacted by the Mayor''s office with a remark like this. They''d say ???Paul, let''s find. Good person to go on the board. And that''s true. And that made for, uh, that made for good boards, non-political boards. Now I''d like to break over to something else that came with that board. [11:30] The Super Intendant of schools was the chief executive officer of the school. All employees were responsible to the board of education through the Super Intendent of the schools with the exception of the secretary of the board, who evidently handled all financial matters. The Super Intendant of Supplies, the Super Intendent of Building and Grounds, The Medical Director, the Cafeteria Director all had to report [12:00] to the board, when reports were called for, through the Super Intendant of schools. So I considered it my job to select the best people available for vacancies, based on professional experience, training, and so on. If I selected the wrong people, then the board should select another Super Intendant. We had a working not written, we had an understanding that they had elected me to pay attention to the details [12:30] and make a recommendation and bring them up to date. And it was an almost ideal situation. Now since my time, and I had nothing to do with it, but since my time I have seen more evidences of politics creeping out of the board''s actions. And uh, not all bad, but there are a lot of things that, in my professional opinion [13:00]  were not good for the welfare of the community. And that''s my only concern with that.\nINTERVIEWER: Now you mentioned that you came to Trenton in 1916?\nLOSER: Yes.\nINTERVIEWER: Would you like to say anything about what the city was like then and how its changed? In the layout, and aspect, and activities, and entertainment, and churches, and all of that sort of thing?\nLOSER: Well okay I''d like to start with something [13:30] I''ve told a number of times, and to me it''s indicative of what, of some of the things that were going on in the city. There was one time just before Labor Day in sixteen and I picked up a copy of the Trenton Times. On the front page, there was a photograph of a check signed by James Carney for six cents to John A. Rogan. [14:00] [both laughing] He had lost the Bible''s loot, you must appreciate that. [laughs] For me it was the indication of what we have here of two strong men and the battle to earn the [inaudible] and the long following success, alright? And it was a spirit, and that was part of it. There were, I shouldn''t be saying this but there were a number of men [14:30] in power in Trenton that were looking for the welfare of the city and working for the welfare of the city. And uh, we had, uh we had pretty solid church attendance in those days, I can remember that. seeing people going to church and uh seeing people going to the church that I, that I attended . There was much more, well bigger church attendance than there is percentage wise [15:00] right now. We had our mixture of uh, various immigrants from European cities. But, while they held to a certain extent the customs of their home towns, they didn''t do that over or above what they were doing for the United States. I, we knew a number of them from these activities, community activities, church activities, but after all, [15:30] they realized that they were a part of something bigger, and they were not the outlet to be catered to, as some groups do, but they retained some of their ethnic traditions, like Italians or Asians [overlap] \nINTERVIEWER: Yes, that''s what I''d think\nLOSER: like the Feast of Lights [overlap]\nINTERVIEWER: So it was moderate? [overlap]\nLOSER: But they were American. Um yes, I think it was moderate. They were Americans though. [16:00] And well uh, you know them, you know of these men, and I know a number of them, there were a lot of men in the city, and around it also, that worked solely for the benefit of their community as a part of their whole state. I can think of a number of women who were active in the Parent-Teacher Associations. And they weren''t working, for uh, self-publicity. [16:30]They were working for the school in which they represented, the community. We had a lot of prominent and very important women in the Trenton community.\nINTERVIEWER: Oh? [overlap]\nLOSER: Annie Feemers, \nINTERVIEWER: Yeah, [overlap]\nLOSER: Sarah Christie, Sarah Asktee, and uh talking about one Mrs. John Curney.\nINTERVIEWER: Yes.\nLOSER: And Mrs. Tom Curney. She was very active during the war. [17:00] And uh, in various ??? she went to go on to pick up twenty-five to fifty nights. Outstanding people! Who were selfless, who were working hard-\nINTERVIEWER: It made a lot of difference to Trenton.\nLOSER: It certainly did. They weren''t always scrawling, scrapping between sections. I was talking to Dr. Elizabeth McDowell the other day, a matter of fact we made a tape, and she was talking about how excited she was when she came to Trenton, what a wonderful place she thought it was, which was very refreshing.\nINTERVIEWER: Yeah?\nLOSER: Sure. Who you kidding? I came down the Pennsylvania railroad, crossing the Delaware River, [17:30] Trenton takes, uh Trenton makes the world takes, and I think yea sure that''s a good place. And uh, I arrived here, as I told you, as an assistant football coach and at that time, in the place where Junior King now stands was YMCA athletic field. And uh, [18:00] that was the year that we um, oh we had the epidemic uh, \nINTERVIEWER: Flu?\nLOSER: No not the Flu, the paralyzing disease,\nINTERVIEWER: Polio?\nLOSER: Yes, yes polio. The polio epidemic in sixteen. It''d end up in the schools for a month. And we had these boys out practicing football however they couldn''t go out on the athletic field, but we could take them out on the playing field. [18:30] And these kids would come out and they were good regular kids you know. I want to say something about that. From three and a half years, yes for three and a half years when I came back to Trenton I was Vice Principal of high school and we were working under, I told you, those pretty horrible conditions. Then for five years I was out here at Junior King for Principal. And that makes nine years in which I was a chief. [19:00] Out here they call that security office, uh chief disciplinary office in the school. And um, we had some discipline trouble but, If I caught a youngster doing something that he shouldn''t have been doing that was bad and I gave him the punishment for it, if he knew [19:30] and I had to talk to him and give him a punishment, he''d accept it. He''d say well I did that and therefor I had it coming to me. And I don''t see that attitude today. We couldn''t get away with it now.\nINTERVIEWER: No?!\nLOSER: The kids back then were awfully fair as long as they felt that they were being fairly treated. [20:00] And we didn''t have kids saying they''d burn down somebody''s house just because he was disciplined the day before in school or anything like that, you know? I noticed to my sorrow a change in the attitude of the people. Because those kids who I am talking about are in my opinion regular, who would stand up and take punishment as long as they felt they had it coming to them. Most of the time they did. So, then the YMCA had two big organizations [20:30] going on at that time. The one down town and the Cook YMCA. I lived at the Cook YMCA my first year and I lived at the dormitories there. I''d seen the benefit that those institutions had on the community. And there were boys clubs, different types than our organized boys clubs which incidentally I think is a schools job. But um, [21:00] they had these organizations working for one thing and that was just to increase the moral standards of the community, and to give these students something really in their lives enjoy. I don''t uh, there is a lot you could talk about as far [21:30] with this but to get over the pedicle thing of the phase uh I just don''t want, uh there shouldn''t be shame in why it had to be discontinued and torn down. \nINTERVIEWER: What was the reason for that?\nLOSER: It was my understanding that uh, that was a part, that was a segment of a donation and one of the provisions in the grant was that the building should be used for YMCA purposes only. To not be used for anything else. And there was no more YMCA there, [22:00] the building was deteriorating so the only thing to do was to tear it down. That was a Cook grant, you know. That did serve a real purpose. \nINTERVIEWER: [overlap] Yeah that''s true.\nLOSER: It served a tremendous purpose there. It had Al Back, who was well known among the sporting community in the town. \nINTERVIEWER: Mhm.\nLOSER: A good ex-potter who was a good athlete who was working for boys out there, and he did a marvelous job. I hope the kids got a lot out of, I mean they had a generally good [22:30] athletic program. What about the growth and change in Trenton? There''s been quite a lot of change in some important industries that moved out and some that remained and stayed important. And that''s really sad. Once you take Trenton potters you take Rollinngs, two of the big ones. The [23:00] people who made the tire making machine, uh, the Throfts! and that uh, all of the rubber plants, Madix Pottery, and oh! Uh between this mentioned Questish Pottery went out of business and it has made a difference tremendously! Because in the town mechanics yes, because I don''t know what the [23:30] total number of mechanically, uh mechanical workers I''m thinking plants uh like General Motors out here, uh how many plants are around town or how many people are applying, when you take a plant like Rollings out of it, you are leaving people who will have to earn their living by [24:00] either by working by working in a service industry or working in government. So, that''s about what it is. \nINTERVIEWER: Well state government has made a lot of difference \nLOSER: [overlap] oh yes!\nINTERVIEWER: in population and the rate of growth and success in business. \nLOSER: [overlap] Yes, well that''s sort of what is come to it. Community allows it. We take those buildings out of there [inaudible] and that would be a tremendous benefit. \nINTERVIEWER: What about the changes in the layout of the city, and all of the and all one-way streets and additional buildings you''ve seen since you came? \nLOSER: There''s been a lot of that. All tremendous buildings [24:30] like royal''s new,\nINTERVIEWER: all of memorial''s new\nLOSER: and all those state, all of those state phone and operated buildings down their , um \nINTERVIEWER: the apartment residences up there\nLOSER: and um if you take West Stacy from the capital out to Callon see what happens. \nINTERVIEWER: Sure.\nLOSER: Uh, and, [25:00] the, so there''s a pretty big ghetto district scattered around, that''s one that one we''d like to reevaluate. Poor houses, poor living facilities, and that''s not going to the absentee landlord, is it? and that''s part of the ball game.\nINTERVIEWER: Sure is. \nLOSER: and uh, it isn''t only in the poor houses. [laughs] I know some [25:30] apartment houses where they actually keep [inaudible, laughing]. \nINTERVIEWER: Right, exactly. \nLOSER: No, I have liked Trenton. We''ve been very happy here, and the town has been good to me. I liked it, I was going to say, I learned to know a lot of very very fine people. And so, I''ve lived here, in September, I''ll have lived here for sixty years. [laughs] [26:00]\nINTERVIEWER: Well thank you very much for this sir. The information has been fascinating, and I am sure it will be very useful as a historical record. \nLOSER: Well,\nINTERVIEWER: [interrupts] When we get this transcribed I will submit a copy to you, if I ever do get it transcribed.\nLOSER: Thanks for listening.\nINTERVIEWER: I can''t wait to listen.\nLOSER: I think I talked a little too much.\nINTERVIEWER: No, not at all. \nLOSER: I really meant what I said when I said I liked Trenton.\nINTERVIEWER: Well thank you very much.\n            [end of interview]\n');

INSERT INTO HAS_TRANSCRIPT(Transcript_ID, Recording_title)
VALUES ('002', 'Millner, Joel');

/*Edit/Update a Recording*/
UPDATE RECORDING
SET Recording_title = 'Joel Millner Interview'
WHERE Recording_title = 'Millner, Joel';

/*Edit/Update a Transcript*/
UPDATE TRANSCRIPT
SET Transcript_ID = '004'
WHERE Transcript_ID = '001';

/*Edit/Update a Speaker*/
UPDATE SPEAKER
SET Name = 'Herman Finkle'
WHERE Speaker_number = 1;
