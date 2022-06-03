db.movies.find({"rating.average":{$gt:7}})
db.movies.find({genres:"Drama"}).pretty()

db.movies.find({genres:["Drama"]}).pretty()

db.movies.find({runtime:{$in :[30,42]}}).pretty()
db.movies.find({"rating.average":{$gt:9}}).count()
db.movies.find({"rating.average":{$gt:9.5}}).count()
db.movies.find({"rating.average":{$gt:9.4}}).count()
db.movies.find({"rating.average":{$gt:9.3}}).count()

--$or operator
db.movies.find({$or:[{"rating.average":{$lt:5}},{"rating.average":{$gt:9.3}}]}).pretty()

db.movies.find().count()

db.movies.find({$or:[{"rating.average":{$lt:5}},{"rating.average":{$gt:9.3}}]}).count() --4

db.movies.find({$nor:[{"rating.average":{$lt:5}},{"rating.average":{$gt:9.3}}]}).count()  --236

--$and operator

db.movies.find({$and:[{"rating.average":{$gt:9}},{genres:"Drama"}]}).count()

use user

db.users.insertMany([{name:"savi",hobbies:[{title:"sports",frequency:3},{title:"crafts",frequency:3}],phone:239740824408},
{name:"savi",hobbies:[{title:"cooking",frequency:4},{title:"cars",frequency:3}],phone:"8970092",age:27}
])

db.users.find(
    {
        age:{
            $exists:true
        }
    }
).pretty()

db.users.find(
    {
        age:{
            $exists:true,
            $gt:27
        }
    }
).pretty()

db.users.find(
    {
        age:{
            $exists:true,
            $gte:27
        }
    }
).pretty()

db.users.insertOne({name:"tansika",hobbies:[{title:"gardening",frequency:5},{title:"swimming",frequency:6}],phone:"230907994",age:null})



db.users.find({
    phone:{
        $type:"string"
    }
}).pretty()

db.users.find({
    phone:{
        $type:["string","number","double"]
    }
}).pretty()


use movieData

db.movies.findOne()
db.movies.find({ summary:"musical"}).pretty() --no Data
db.movies.find({ summary:/musical/}).pretty()  --with regex

db.movies.find({ summary:/mu/}).pretty(

    ------------------------------------------------------------

    use financialData

    db.sales.insertMany(
        [
            {
                volume:100,
                target:120
            },
             {
                volume:90,
                target:100
            },
             {
                volume:200,
                target:177
            }
    ]
    )


db.sales.find().pretty()

db.sales.find({$expr:{   ---not working 
    $gt:["volume","target"]
}}).pretty()

db.sales.find({$expr:{     -- here volume should be greater than target
    $gt:["$volume","$target"]
}}).pretty()

db.sales.find({$expr:{
    $gt: [{
        $cond:{                 --check
            if:{ $gte:["$volume",190]},
        then:
            $subtract:["$volume",10],
        else:
            "$volume"
    }},"$target"]}
}).pretty()

db.users.find({hobbies:"sports"}).pretty()
db.users.find({hobbies:{title:"sports",frequency:3}}).pretty()

db.users.find({"hobbies.title":"sports"}).pretty()

--Day 7 practice

db.users.insertOne({
    name:"krish",
    hobbies:["Sports","Cooking","Hiking"]
})

--ant to read data hose array size is 3 (use of $size operator)

db.users.find({
    hobbies:{$size:3}
}).pretty()

----------------------------

use boxOffice

db.moviestats.insertMany([
    {
        Title:"The Last Student Returns",
    meta:{
        rating:9.5,
        aired:2018,
        runtime:100
    },
    visitors:1300000,
    epectedVisitors:1500000,
    genres:[
        "thriller","drama","action"
    ]
    },
    {
        Title:"Teach me if you can",
    meta:{
        rating:8.5,
        aired:2014,
        runtime:0
    },
    visitors:590378,
    epectedVisitors:500000,
    genres:[
        "action","thriller"
    ]
    }
])

db.moviestats.find({ genres:["action","thriller"]}).pretty()

-- use of all operator to match all selection

db.moviestats.find({ genres:{$all:["action","thriller"]}}).pretty()

db.moviestats.insertMany([
    {
        Title:"Supercharged Teaching",
    meta:{
        rating:9.3,
        aired:2016,
        runtime:60
    },
    visitors:370000,
    epectedVisitors:1000000,
    genres:[
        "thriller","action"
    ]
    }
]
)

db.users.find({
    $and: [
        {
            "hobbies.title":"gardening"
        },
        {
            "hobbies.frequency":{
                $gte:2
            }
        }
    ]
}).pretty()

-- use of elematch to avoid unwanted

db.users.find({
    hobbies:{
        $elemMatch:{
            title:"gardening",
            frequency:{
                $gte:3
            }
        }
    }
}).pretty()

--cursor

db.movies.find().count() --240

db.movies.find().pretty()

--cursor it

--it
--it
db.movies.find().next()  --find method returns the cursor

--in javascript we can create variable with three concepts var,let and const(block scope)

const dataCursor=db.movies.find()

dataCursor.next()  --here e have 240 documents so we can use use it nearly 240 times

dataCursor.forEach(doc => { printjson(doc)})  -- it will print all documents and the cursor no points hich has no documnet

dataCursor.hasNext() -- false because it has no document points to

dataCursor.hasNext --it will show the function logic

----sorting the cursor

db.movies.findOne() 

--1 and -1

db.movies.find().sort({"rating.average":1}).pretty()

db.movies.find().sort({"rating.average":1,runtime:-1}).pretty() -- 1 for ascending and -1 for descending

db.movies.find().sort({"rating.average":1,runtime:-1}).sort({"rating.average":1}).pretty()

db.movies.find().sort({"rating.average":1,runtime:-1}).sort({"rating.average":1}).skip(10).pretty()  --it will skip the first 10 data

--include specific fields  (use 1 for include and 0 for exclude)
db.movies.find({},{name:1,runtime:1}).pretty()

db.movies.find({},{name:1,runtime:1,_id:0}).pretty()

db.movies.find({},{name:1,genres: 1,"rating.average":1,runtime:1,"schedule.time":1,_id:0}).pretty()

db.movies.find({genres:"Drama"},{"genres.$":1}).pretty() --to get only genres and it as drama only

db.movies.find({
    genres:{
        $all:["Drama","Horror"]
    }
},
{"genres.$":1}
).pretty()

-- it ill display only the horror
db.movies.find(
    {genres:"Drama"},
    {
        genres:{
            $elemMatch: {
                $eq:"Horror"
            }
        }
    }
).pretty()

-------------------------------
db.movies.find({"rating.average":{$gt:9}},{genres:{$slice: 2},name:1}).pretty() -- it will slice only 2 data in genres 

db.movies.find({_id: ObjectId("626b6422c7cac5ca19adecbf")},{genres:1}) -- it will take one more value value in genres