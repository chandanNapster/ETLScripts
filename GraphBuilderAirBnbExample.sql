STEPS FOLLOWED TO CREATE A PROPERTY GRAPH FOR CONDUCTING EXPERIMENTS
Goto -->cd Desktop/PGQL/pgx-19.3.1

sudo ./bin/pgx-jshell


var builder = session.createGraphBuilder(IdGenerationStrategy.USER_IDS,IdGenerationStrategy.USER_IDS)

//NODE CREATION

builder.addVertex(22).setProperty("Name","Ron").setProperty("age","32").setProperty("Gender", "Male").addLabel("USER")
builder.addVertex(10).setProperty("Name","Dave").setProperty("age","42").setProperty("Gender", "Male").addLabel("USER")
builder.addVertex(16).setProperty("Name","Rohan").setProperty("age","52").setProperty("Gender", "Male").addLabel("USER")
builder.addVertex(4).setProperty("Name","David").setProperty("age","23").setProperty("Gender", "Male").addLabel("USER")

builder.addVertex(8).setProperty("Name","Shradha").setProperty("age","31").setProperty("Gender", "Female").addLabel("HOST")
builder.addVertex(14).setProperty("Name","Renna").setProperty("age","39").setProperty("Gender", "Female").addLabel("HOST")
builder.addVertex(23).setProperty("Name","John").setProperty("age","34").setProperty("Gender", "Male").addLabel("HOST")

builder.addVertex(7).setProperty("Name","Bedroom, Hall and Kitchen").addLabel("AMENITY")
builder.addVertex(13).setProperty("Name","TV,Fridge and Sofa").addLabel("AMENITY")
builder.addVertex(19).setProperty("Name","Seaview and free parking").addLabel("AMENITY")
builder.addVertex(2).setProperty("Name","Private Room").addLabel("AMENITY")

builder.addVertex(6).setProperty("Name","House on Grafton").addLabel("LISTING")
builder.addVertex(12).setProperty("Name","Unit 14E3 Raymond Street").addLabel("LISTING")
builder.addVertex(18).setProperty("Name","Freeman College Hill").addLabel("LISTING")
builder.addVertex(1).setProperty("Name","Columbia House").addLabel("LISTING")

builder.addVertex(5).setProperty("Comment","Awesome Place").addLabel("REVIEW")
builder.addVertex(11).setProperty("Comment","Host is very polite").addLabel("REVIEW")
builder.addVertex(17).setProperty("Comment","Free parking was a bonus").addLabel("REVIEW")
builder.addVertex(0).setProperty("Comment","Good Place to relax").addLabel("REVIEW")

builder.addVertex(3).setProperty("FromDate","02-03-2020").setProperty("isAvailable","Yes").addLabel("BOOKING_DETAIL")
builder.addVertex(15).setProperty("FromDate","21-04-2021").setProperty("isAvailable","Yes").addLabel("BOOKING_DETAIL")
builder.addVertex(20).setProperty("FromDate","20-12-2020").setProperty("isAvailable","Yes").addLabel("BOOKING_DETAIL")
builder.addVertex(9).setProperty("FromDate","02-04-2020").setProperty("isAvailable","Yes").addLabel("BOOKING_DETAIL")



//EDGE CREATION

builder.addEdge(100,17,18).setProperty("rating","4").setLabel("REVIEW_FOR")
builder.addEdge(101,11,12).setProperty("rating","4").setLabel("REVIEW_FOR")
builder.addEdge(102,5,6).setProperty("rating","4").setLabel("REVIEW_FOR")
builder.addEdge(103,0,1).setProperty("rating","5").setLabel("REVIEW_FOR")

builder.addEdge(104,18,19).setLabel("HAS")
builder.addEdge(105,18,20).setLabel("HAS")
builder.addEdge(106,12,13).setLabel("HAS")
builder.addEdge(107,12,15).setLabel("HAS")
builder.addEdge(108,6,7).setLabel("HAS")
builder.addEdge(109,6,9).setLabel("HAS")
builder.addEdge(110,1,2).setLabel("HAS")
builder.addEdge(111,1,3).setLabel("HAS")

builder.addEdge(112,16,4).setProperty("since","2012").setLabel("FRIEND_OF")
builder.addEdge(113,4,16).setProperty("since","2012").setLabel("FRIEND_OF")
builder.addEdge(114,4,22).setProperty("since","2011").setLabel("FRIEND_OF")
builder.addEdge(115,22,4).setProperty("since","2011").setLabel("FRIEND_OF")
builder.addEdge(116,10,22).setProperty("since","2012").setLabel("FRIEND_OF")
builder.addEdge(117,22,10).setProperty("since","2012").setLabel("FRIEND_OF")
builder.addEdge(118,8,23).setProperty("since","2014").setLabel("FRIEND_OF")
builder.addEdge(119,23,8).setProperty("since","2014").setLabel("FRIEND_OF")
builder.addEdge(120,14,23).setProperty("since","2015").setLabel("FRIEND_OF")
builder.addEdge(121,23,14).setProperty("since","2015").setLabel("FRIEND_OF")

builder.addEdge(122,16,14).setProperty("since","2000").setLabel("KNOWS")
builder.addEdge(123,10,14).setProperty("since","2000").setLabel("KNOWS")
builder.addEdge(124,14,22).setProperty("since","2009").setLabel("KNOWS")
builder.addEdge(125,22,8).setProperty("since","2009").setLabel("KNOWS")
builder.addEdge(126,22,23).setProperty("since","2011").setLabel("KNOWS")
builder.addEdge(127,4,8).setProperty("since","2011").setLabel("KNOWS")
builder.addEdge(128,23,4).setProperty("since","2009").setLabel("KNOWS")

builder.addEdge(129,16,17).setProperty("on","28-07-2016").setLabel("WROTE")
builder.addEdge(130,10,11).setProperty("on","28-07-2016").setLabel("WROTE")
builder.addEdge(131,4,5).setProperty("on","01-04-2018").setLabel("WROTE")
builder.addEdge(132,22,0).setProperty("on","02-03-2016").setLabel("WROTE")

builder.addEdge(133,14,18).setProperty("since","2000").setLabel("OWNS")
builder.addEdge(134,14,12).setProperty("since","2003").setLabel("OWNS")
builder.addEdge(135,23,1).setProperty("since","2000").setLabel("OWNS")
builder.addEdge(136,8,6).setProperty("since","2009").setLabel("OWNS")



//GRAPH BUILDER
var graph = builder.build()

//QUERY GRAPH

var resultSet = graph.queryPgql("Select x.Name Match (x)")

resultSet.print(10)

//OR THIS CAN BE DONE AS WELL
 graph.queryPgql("Select x.Name MATCH (x)").print(10)

//QUERY 0 A VERY BASIC QUERY
graph.queryPgql("Select label(x),label(e),label(y) Match (x)-[e]->(y) Order By 1 ASC").print(30)


//GRAPH NAVIGATION QUERY
graph.queryPgql("Select u.Name,b.Name,l.Name,d.FromDate MATCH (u:USER)-/:KNOWS*/->(b)-[o:OWNS]->(l:LISTING)-[h:HAS]->(d:BOOKING_DETAIL) WHERE l.Name = 'House on Grafton'").print(10)

//ANOTHER QUERY
graph.queryPgql("Select u.Name,b.Name,label(o),l.Name,label(o1), c.Name MATCH (u:USER)-/:KNOWS*/->(b)-[o:OWNS]->(l:LISTING),(c)-[o1:OWNS]-(l)").print(10) 

//ANOTHER QUERY 2
graph.queryPgql("Path p1 as (a)-[:KNOWS]->(b) Where Not Exists (Select * Match (a)-[:OWNS]->(c)->() Where Not Exists (Select * Match (c)->())) Select x.Name,y.Name Match (x)-/:p1*/->(y)").print(10) 

//QUERY 3
graph.queryPgql("Path p1 as (a)-[:KNOWS]->(b)-[:FRIEND_OF]->(d) Where Exists (Select * Match (b)-[:OWNS]->()) Select x.Name,y.Name Match (x)-/:p1+/->(y)").print(10)

//QUERY 4
graph.queryPgql("Select a.Name, b.Name MATCH (a)-[k:KNOWS]->(b) Where Exists (Select * Match (m)-[k1:FRIEND_OF]->(b)<-[k2:FRIEND_OF]-(n) Where m <> n)").print(10)

//QUERY 5
graph.queryPgql("Select a.Name, b.Name MATCH (a)-/:KNOWS*/->(b)-[f:FRIEND_OF]->(e) Where exists (Select * Match (b)-[:HAS]->()-[:OWNS]->(l)  )").print(10)

//QUERY 6 to simulate iso morphism based semantcis

graph.queryPgql("Select a.Name, b.Name MATCH (a)-/:KNOWS*/->(b)-[f:FRIEND_OF]->(e) Where exists (Select * Match (b)-[:OWNS]->()-[:HAS]->(l) WHERE b <> l) AND a <> b").print(10)

//Query 7
graph.queryPgql("Path p1 as (u:USER)-[:WROTE]->(r)-[:REVIEW_ FOR]->(l) Where exists (Select * Match (u) Where u.age > '20') Path p2 as (u:USER) Select m.Name Match (m)-/:p1/->(n) ").print(10)


//QUERY 8

graph.queryPgql("Path p1 as (u:USER)-[:WROTE]->(r)-[:REVIEW_FOR]->(l) Where exists (Select * Match (u) Where u.age > '20') Path p2 as (u1)-[:WROTE]->(r)-[:REVIEW_FOR]->(l) Where exists (Select * Match (u1) Where u1.age < '65') Select m.Name, m.age Match (m)-/:p1|p2/->(n) ").print(10)

//QUERY 9
graph.queryPgql("Path p1 as (u:USER)-[:WROTE]->(r)-[:REVIEW_FOR]->(l) Where exists (Select * Match (u) Where u.age > '30') Path p2 as (u1:USER)-[:WROTE]->(r)-[:REVIEW_FOR]->(l) Where exists (Select * Match (u1) Where u1.age < '25') Select m.Name, m.age, label(m), label(n) Match (m)-/:p2/->(n)-/:p1/->(v) ").print(10)

//QUERY 10 UNION QUERY (Does not work properly) I need to mension this in the reflections section.....
graph.queryPgql("Path p1 as (u:USER)-[:WROTE]->(r)-[:REVIEW_FOR]->(l) Where exists (Select * Match (u) Where u.age > '20') Path p2 as (u1:USER)-[:WROTE]->(r)-[:REVIEW_FOR]->(l) Where exists (Select * Match (u1) Where u1.age < '35') Select m.Name, m.age Match (m)-/:p1|p2/->(n) ").print(10)

//QUERY 11

graph.queryPgql("Select Distinct u.Name,b.Name,d.Name Match (u:USER)-/:KNOWS*/->(b)-[:FRIEND_OF]->(d) Where Not Exists (Select * Match (b)-[:OWNS]->(l)-[HAS]->(a), (l)<-/:REVIEW_FOR*/-())").print(10)

//QUERY 12 that shows how to use difference in PGQL with the help of not exists clause.
graph.queryPgql("Select u.Name Match (u)-[:FRIEND_OF]->(v) Where Not Exists (Select * Match (u)-[w:WROTE]->(r:REVIEW), (u)-[o:OWNS]->(l:LISTING)) ").print(10)

//QUERY 13
graph.queryPgql("Path p1 As ()-[:KNOWS]->(b)-[:KNOWS]->() Where Exists (Select * Match (b)-[:OWNS|WROTE]->()) Select x.Name,y.Name Match (x)-/:p1+/->(y) ").print(10)

//EXPERIMENTS FRO VARIOUS SHAPES
//GRAPH PATTERN MATCHING

//CHAINS OF LENGTH 3
graph.queryPgql("Select x,k,y,o,z,h,w Match (x)-[k:KNOWS]->(y),(y)-[o:OWNS]->(z),(z)-[h:HAS]->(w) Order By 1 ASC").print(200)

//TREE
graph.queryPgql("Select * Match (u)-[k:KNOWS]->(h:HOST), (h)-[f:FRIEND_OF]->(h2:HOST),(h)-[o:OWNS]->(l:LISTING),(h)-[k2:KNOWS]->(u2:USER),(l)-[h3:HAS]->(b:BOOKING_DETAIL), (l)-[h4:HAS]->(a:AMENITY), (u)-[w:WROTE]->(r:REVIEW)").print(200)


//TREE MAX DEGREE 3 AND MAX LENGTH 3
graph.queryPgql("Select u,h,h2,l,b,a Match (u)-[k:KNOWS]->(h:HOST), (h)-[f:FRIEND_OF]->(h2:HOST),(h)-[o:OWNS]->(l:LISTING),(h)-[k2:KNOWS]->(u2:USER),(l)-[h3:HAS]->(b:BOOKING_DETAIL), (l)-[h4:HAS]->(a:AMENITY), (u)-[w:WROTE]->(r:REVIEW)").print(200)

//STAR OF LENGTH 4 AND MAX DEGREE 4
graph.queryPgql("Select * Match (u:USER)-[k:KNOWS]->(h:HOST), (h)-[f:FRIEND_OF]->(h2:HOST), (h2)-[o:OWNS]->(l:LISTING), (l)<-[REVIEW_FOR]-(r:REVIEW), (l)-[h3:HAS]->(a:AMENITY),(l)-[h4:HAS]->(b:BOOKING_DETAIL)").print(200)

//STAR CHAIN PATTERN Max Degree 4 and Path Length 4
graph.queryPgql("Select * Match (h1:HOST)-[:FRIEND_OF]->(h:HOST), (h)-[k:KNOWS]->(u:USER), (h)-[:FRIEND_OF]->(h2:HOST), (h)-[:KNOWS]->(u1:USER),(u1)-[:FRIEND_OF]->(u2:USER),(u2)-[:KNOWS]->(h3:HOST),(u2)-[:KNOWS]->(h4:HOST),(u2)-[:WROTE]->(r:REVIEW)").print(200)

graph.queryPgql("Select Distinct h1.Name,h.Name,u1.Name,u2.Name,r.Comment Match (h1:HOST)-[:FRIEND_OF]->(h:HOST), (h)-[k:KNOWS]->(u:USER), (h)-[:FRIEND_OF]->(h2:HOST), (h)-[:KNOWS]->(u1:USER),(u1)-[:FRIEND_OF]->(u2:USER),(u2)-[:KNOWS]->(h3:HOST),(u2)-[:KNOWS]->(h4:HOST),(u2)-[:WROTE]->(r:REVIEW)").print(200)

//PLAIN CYCLE
graph.queryPgql("Select * Match (u:USER)-[k:KNOWS]->(h:HOST), (h)-[:FRIEND_OF]->(h2:HOST), (h2)-[:KNOWS]->(u2:USER),(u2)-[:FRIEND_OF]->(u3:USER),(u3)-[:KNOWS]->(h3:HOST), (h3)-[:FRIEND_OF]->(u)").print(200)

//PETAL
graph.queryPgql("Select * Match (h:HOST)-[:FRIEND_OF]->(h2:HOST), (h2)-[:FRIEND_OF]->(h3:HOST), (h3)-[o:OWNS]->(l:LISTING),(h)-[k:KNOWS]->(u:USER),(u)-[w:WROTE]->(r:REVIEW),(r)-[rf:REVIEW_FOR]->(l)").print(200)

//FLOWER
graph.queryPgql("Select * Match (u:USER)-[w:WROTE]->(r:REVIEW),(r)-[rf:REVIEW_FOR]->(l:LISTING),(u)-[k:KNOWS]->(h:HOST),(h)-[o:OWNS]->(l), (u)-[f:FRIEND_OF]->(u2:USER),(u2)-[f2:FRIEND_OF]->(u3:USER),(u)-[k2:KNOWS]->(h2:HOST),(h2)-[:FRIEND_OF]->(h3:HOST),(h2)-[:OWNS]->(l3:LISTING)").print(200)

//FLOWER WITH RESTRICTIONS
graph.queryPgql("Select * Match (u:USER)-[w:WROTE]->(r:REVIEW),(r)-[rf:REVIEW_FOR]->(l:LISTING),(u)-[k:KNOWS]->(h:HOST),(h)-[o:OWNS]->(l), (u)-[f:FRIEND_OF]->(u2:USER),(u2)-[f2:FRIEND_OF]->(u3:USER),(u)-[k2:KNOWS]->(h2:HOST),(h2)-[:FRIEND_OF]->(h3:HOST),(h2)-[:OWNS]->(l3:LISTING) Where u.Name = 'Ron' AND u <> u2 AND u <> u3 AND u2<>u3 AND l<>l3 AND h <> h2").print(200)

//FLOWER 2
graph.queryPgql("Select * Match (u:USER)-[k:KNOWS]->(h:HOST),(h)-[o:OWNS]->(l:LISTING),(u)-[w:WROTE]->(r:REVIEW),(r)-[rf:REVIEW_FOR]->(l),(u)-[k2:KNOWS]->(h2:HOST),(h2)-[f1:FRIEND_OF]->(h3:HOST),(u)-[k3:KNOWS]->(h4:HOST),(h4)-[f2:FRIEND_OF]->(h5:HOST),(h4)-[:KNOWS]->(u2:USER),(h4)-[:OWNS]->(l2:LISTING) Where u.Name = 'Ron'").print(200)







//EXPERIMENTS FOR SHAPE ANALYSIS
//GRAPH PATTERN MATCHING
//CHAIN OF LENGTH 3 
graph.queryPgql("Select DISTINCT u.Name,h.Name,a.Name Match (u:USER)-[k:KNOWS]->(h),(h)-[o:OWNS]->(l:LISTING),(l)-[v:HAS]->(a:AMENITY) WHERE l.Name ='Columbia House'").print(200)


//TREE WITH MAX DEGREE 3 AND PATH LENGTH 3
graph.queryPgql("Select DISTINCT h.Name,l.Name,a.Name,w.on Match (u)-[k:KNOWS]->(h:HOST), (h)-[f:FRIEND_OF]->(h2:HOST),(h)-[o:OWNS]->(l:LISTING),(h)-[k2:KNOWS]->(u2:USER),(l)-[h3:HAS]->(b:BOOKING_DETAIL), (l)-[h4:HAS]->(a:AMENITY), (u)-[w:WROTE]->(r:REVIEW) WHERE u.Name = 'Dave'").print(200)

//STAR OF LENGTH 4 AND MAX DEGREE 4
graph.queryPgql("Select DISTINCT u.Name,h.Name,r.Comment Match (u:USER)-[k:KNOWS]->(h:HOST), (h)-[f:FRIEND_OF]->(h2:HOST), (h2)-[o:OWNS]->(l:LISTING), (l)<-[REVIEW_FOR]-(r:REVIEW), (l)-[h3:HAS]->(a:AMENITY),(l)-[h4:HAS]->(b:BOOKING_DETAIL) WHERE l.Name = 'House on Grafton' AND u.age > '30'").print(200)

//STAR CHAIN PATTERN Max Degree 4 and Path Length 4
graph.queryPgql("Select DISTINCT h.Name,u1.Name,r.Comment Match (h1:HOST)-[:FRIEND_OF]->(h:HOST), (h)-[k:KNOWS]->(u:USER), (h)-[:FRIEND_OF]->(h2:HOST), (h)-[:KNOWS]->(u1:USER),(u1)-[:FRIEND_OF]->(u2:USER),(u2)-[:KNOWS]->(h3:HOST),(u2)-[:KNOWS]->(h4:HOST),(u2)-[:WROTE]->(r:REVIEW) WHERE h1.Name = 'Shradha' OR u2.Name = 'Ron'").print(200)

//PLAIN CYCLE
graph.queryPgql("Select u.Name,h.Name Match (u:USER)-[k:KNOWS]->(h:HOST), (h)-[:FRIEND_OF]->(h2:HOST), (h2)-[:KNOWS]->(u2:USER),(u2)-[:FRIEND_OF]->(u3:USER),(u3)-[:KNOWS]->(h3:HOST), (h3)-[:FRIEND_OF]->(u)").print(200)

//PETAL
graph.queryPgql("Select r.Comment,l.Name Match (h:HOST)-[:FRIEND_OF]->(h2:HOST), (h2)-[:FRIEND_OF]->(h3:HOST), (h3)-[o:OWNS]->(l:LISTING),(h)-[k:KNOWS]->(u:USER),(u)-[w:WROTE]->(r:REVIEW),(r)-[rf:REVIEW_FOR]->(l)").print(200)

//FLOWER
graph.queryPgql("Select DISTINCT h.Name,l3.Name,r.Comment Match (u:USER)-[w:WROTE]->(r:REVIEW),(r)-[rf:REVIEW_FOR]->(l:LISTING),(u)-[k:KNOWS]->(h:HOST),(h)-[o:OWNS]->(l), (u)-[f:FRIEND_OF]->(u2:USER),(u2)-[f2:FRIEND_OF]->(u3:USER),(u)-[k2:KNOWS]->(h2:HOST),(h2)-[:FRIEND_OF]->(h3:HOST),(h2)-[:OWNS]->(l3:LISTING) WHERE u.Name = 'David'").print(200)


//FLOWER WITH DIFFERENCE
graph.queryPgql("Select DISTINCT h.Name,l3.Name,r.Comment Match (u:USER)-[w:WROTE]->(r:REVIEW),(r)-[rf:REVIEW_FOR]->(l:LISTING),(u)-[k:KNOWS]->(h:HOST),(h)-[o:OWNS]->(l), (u)-[f:FRIEND_OF]->(u2:USER),(u2)-[f2:FRIEND_OF]->(u3:USER),(u)-[k2:KNOWS]->(h2:HOST),(h2)-[:FRIEND_OF]->(h3:HOST),(h2)-[:OWNS]->(l3:LISTING) WHERE NOT EXISTS (SELECT * MATCH (h)-[:OWNS]->(l3),(l3)-[:HAS]->(a:AMENITY),(l3)<-[:REVIEW_FOR]-(r))").print(200)

//************************************************************************************
//************************GRAPH NAVIGATION QUERIES************************************
//************************************************************************************

QUERY 1 PATH QUERY
graph.queryPgql("Path p1 AS (u:USER)-[k:KNOWS]->(h)-[o:OWNS]->(l:LISTING)-[v:HAS]->(a:AMENITY) Select DISTINCT u.Name,a.Name Match (u)-/:p1/->(a)").print(200)

QUERY 2 PATH QUERY
graph.queryPgql("Path p1 AS (h1:HOST)-[:FRIEND_OF]->(h)-[o:OWNS]->(l:LISTING)-[v:HAS]->(a:AMENITY) Select DISTINCT u.Name,a.Name Match (u)-/:p1/->(a)").print(200)

QUERY 3 COMBINING QUERY 1 AND QUERY 2 (THIS QUERY DOESNOT WORK AS INTENDED BECUASE WHEN DONE AS -/:p1|p2/-> RESULT SET ONLY DISPLAYED FOR p1)
graph.queryPgql("Path p1 AS (u:USER)-[k:KNOWS]->(h)-[o:OWNS]->(l:LISTING)-[v:HAS]->(a:AMENITY) Path p2 AS (h1:HOST)-[:FRIEND_OF]->(h)-[o:OWNS]->(l:LISTING)-[v:HAS]->(a:AMENITY) Select DISTINCT u.Name,a.Name Match (u)-/:p1|p2+/->(a)").print(200)

QUERY 4
graph.queryPgql("Path p1 AS (u:USER)-[k:KNOWS]->(h)-[o:OWNS]->(l:LISTING)-[v:HAS]->(a:AMENITY) WHERE EXISTS (SELECT * MATCH (h)-[:FRIEND_OF]->(h2:HOST)) Select DISTINCT u.Name,a.Name Match (u)-/:p1+/->(a)").print(200)

QUERY 5
graph.queryPgql("Path p1 AS (u:USER)-[k:KNOWS]->(h:HOST)-[o:OWNS]->(l:LISTING)-[v:HAS]->(a:AMENITY) WHERE EXISTS (SELECT * MATCH (u)-[:WROTE]->(r) ) AND EXISTS (Select * Match (h)-[:FRIEND_OF]->(h2:HOST)-[:OWNS]->(),(h2)-[:FRIEND_OF]->()) AND EXISTS (SELECT * MATCH (l)->()) Select DISTINCT x.Name,y.Name Match (x)-/:p1+/->(y)").print(200)

QUERY 6 TREE CHAIN
graph.queryPgql("Path p1 AS (u:USER)-[k:KNOWS]->(h:HOST)-[o:OWNS]->(l:LISTING)-[v:HAS]->(a:AMENITY) WHERE  EXISTS (SELECT * MATCH (h)-[:FRIEND_OF]->()) AND EXISTS (SELECT * MATCH (l)<-[:OWNS]-()) Select DISTINCT x.Name,y.Name Match (x)-/:p1+/->(y)").print(200)

QUERY 7 STAR ITERATION
graph.queryPgql("Path p1 AS (u:USER)-[k:KNOWS]->(h:HOST)-[k2:KNOWS]->(h2:HOST)-[o:OWNS]->(l:LISTING)<-[rf:REVIEW_FOR]-(r:REVIEW) WHERE  EXISTS (SELECT * MATCH (l)<-[h3:HAS]-(b:BOOKING_DETAIL)) AND EXISTS (SELECT * MATCH (l)<-[h4:HAS]-(a:AMENITY)) Select DISTINCT x.Name,y.Name Match (x)-/:p1+/->(y)").print(200)

QUERY 8 STAR CHAIN CHAIN
graph.queryPgql("Path p1 AS (h1:HOST)-[f1:FRIEND_OF]->(h:HOST)-[k:KNOWS]->(u1:USER)-[f2:FRIEND_OF]->(u2:USER)-[k4:KNOWS]->(h3:HOST) WHERE EXISTS (SELECT * MATCH (u:USER)<-(h)-[f3:FRIEND_OF]->(h2:HOST)) AND EXISTS (SELECT * MATCH (h4:HOST)<-(u2)-[w:WROTE]->(r:REVIEW))  Select DISTINCT x.Name,y.Name Match (x)-/:p1+/->(y)").print(200)

QUERY 9 CYCLE CHAIN --> CANNOT BE EXPRESSED IN PGQL
graph.queryPgql("Path p1 AS (u:USER)-[k:KNOWS]->(h:HOST)-[f1:FRIEND_OF]->(h2:HOST)-[k2:KNOWS]->(u2:USER)-[f2:FRIEND_OF]->(u3:USER)-[k3:KNOWS]->(h3:HOST)-[f3:FRIEND_OF]->(u)  Select DISTINCT x.Name,y.Name Match (x)-/:p1+/->(y)").print(200)


QUERY 10 PETAL CHAIN --> CANNOT BE EXPRESSED IN PGQL
graph.queryPgql("Path p1 AS (h:HOST)-[f1:FRIEND_OF]->(h2:HOST)-[f2:FRIEND_OF]->(h3:HOST)-[o:OWNS]->(l:LISTING)<-[rf:REVIEW_FOR]-(r:REVIEW) WHERE EXISTS (SELECT * MATCH (h2)-[k:KNOWS]->(u:USER)-[w:WROTE]->(r))  Select DISTINCT x.Name,y.Name Match (x)-/:p1+/->(y)").print(200)

QUERY 11 FLOWER WITH ZERO PETAL, TWO CHAIN AND ONE TREE

graph.queryPgql("Path p1 AS (h3:HOST)<-[f3:FRIEND_OF]-(h2:HOST)<-[k2:KNOWS]-(u:USER)-[f1:FRIEND_OF]->(u2:USER)-[f2:FRIEND_OF]->(u3:USER) WHERE EXISTS (SELECT * MATCH (h2)-[o:OWNS]->(l:LISTING)) AND EXISTS (SELECT * MATCH (u)-[k3:KNOWS]->(h4:HOST)-[f4:FRIEND_OF]->(h5:HOST))  Select DISTINCT x.Name,y.Name Match (x)-/:p1+/->(y)").print(200)















