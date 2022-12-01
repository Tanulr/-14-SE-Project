use survey;

INSERT INTO user
values 
(1,	"Tom",	456,	"tom@poll.com",	"56gH"),
(2,	"Hanks",	345,	"hanks@poll.com",	"b123"),
(3,	"Meg",	234,	"meg@poll.com",	"8Jk9"),
(4,	"Ryan",	123,	"ryan@poll.com",	"02k8");

INSERT INTO poll
values
(1,	1,	"Favourite anime",	"Fun"),
(2,	3,	"Happiness Quotient",	"Company");

INSERT INTO poll_question
values
(1	,1,	1	,"Action is better than horror"),
(2	,1	,1	,"Boys secretly like romance"),
(3,	1	,1	,"Deathnote is all time best anime"),
(4	,2	,2	,"Best workplace"),
(5	,2	,2	,"What symptoms when you're stressed"),
(6,	2	,1 ,"Do you think you're trully happy");


INSERT INTO poll_answer
values
(1	,1,	1	,"Yes"),
(2,	1	,1	,"No"),
(3	,1	,2	,"Yes"),
(4,	1	,2	,"No"),
(5	,1	,3	,"Yes"),
(6,	1	,3	,"No"),
(7	,2	,4	,"At home"),
(8,	2	,4	,"Workplace"),
(9	,2	,4	,"Co-working space"),
(10,2	,5,	"Indigestion"),
(11	,2	,5	,"Anxiety"),
(12,2	,5,	"Cry"),
(13	,2	,6	,"Yes"),
(14,2,	6,	"No");

INSERT INTO category
values
(1	,1,	"Past-time"	,"Fun and friendly"),
(2,	2	,"Serious",	"Corporate survey");

INSERT INTO poll_category
values
(1,	1),
(2,	2);

INSERT INTO poll_vote
values
(1,	1,	1,	1,	1),
(2,	1,	2,	4,	1),
(3,	1,	3,	5,	1),
(4,	2,	4,	8,	2),
(5,	2,	5,	11,	2),
(6,	2,	6,	13,	2),
(7,	1,	1,	2,	3),
(8	,1,	2,	4,	3),
(9	,1,	3,	6,	3),
(10	,2,	4,	7,	4),
(11	,2,	5,	10,	4),
(12	,2,	6,	12,	4);