--upsert

db.users.updateOne({
    name:"Maria"
},{$set:{
    age:30,
    hobbies:[{
        title:"good food",
        frequency:3
    }],isSporty:true
}})


db.users.updateOne({
    name:"Maria"
},{$set:{
    age:30,
    hobbies:[{
        title:"good food",
        frequency:3
    }],isSporty:true
}},
{upsert: true}
)


---------------------------updating array elements

---find and update
db.users.find(
    {
        $and: [
            {"hobbies.title":"Sports"},
            {"hobbies.frequency":{$gt:3}}
        ]
    }
).pretty()

db.users.find(
    {
       hobbies:{
           $elemMatch:{
              title:"Sports",
              frequency:{$gt:3}  --count 2
           }
       }
    }
).pretty()


db.users.updateMany(
    {
          hobbies:{
           $elemMatch:{
              title:"Sports",
              frequency:{$gt:3}  
           }
       }
    },
    {
        $set:{
            "hobbies.$.highFrequency":true
        }
    }
)

db.users.find(     {         $and: [             {"hobbies.title":"Sports"},             {"hobbies.frequency":{$gt:2}}         ]     } ).count()


--when use $ it will match only first matched document
db.users.updateMany(
    {"hobbies.frequency":{$gt:2}},
    {
        $set:{
            "hobbies.$.highFrequency":true
        }
    }
)

db.users.updateMany(
    {"hobbies.frequency":{$gt:2}},
    {
        $set:{
            "hobbies.$.goodFrequency":true
        }
    }
)

db.users.updateMany(
    {"hobbies.frequency":{$gt:2}},
    {
        $set:{
            "hobbies.$[].goodFrequency":true
        }
    }
)

db.users.updateMany(
    {"hobbies.frequency":{$gt:3}},
    {
        $set:{
            "hobbies.$[el].goodFrequency":true
        }
    },
    {
        arrayFilters:[{"el.frequency":{$gt:2}}]
    }
)
------$ ill update only first element in hobbies array
---------------$[] like a for loop and update in all documents in hobbies array 
db.users.find({totalAge:{$gt:30}}).pretty()

db.users.updateMany({totalAge:{$gt:30}},{
    $inc:{
        "hobbies.$[].frequency":-1   
    }
})


----------------$push ->add elements to an array   if you execute multiple times it ad duplicate values

db.users.updateOne({name:"Maria"},{$push:{
    hobbies:[{
        title:"Sports",     --if we write two times duplicate data occur
        frequency:2
    }]
}})

db.users.updateOne({name:"Maria"},{
    $push:{
        hobbies:{
            $each:[{
                title:"Good wine",
                frequency:1
            },
            {
                title:"hiking",
                frequency:2
            }
            ],
            $sort:{
                frequency: -1
            }
        }
    }
})

--- to remove element use pull operator

db.users.updateOne({name:"Maria"},{
    $pull:{
        hobbies:{
            title:"Good wine"
        }
    }
})

--$pop 
db.users.updateOne({
    name:"krish"
},{
    $pop:{
        hobbies:1
    }
})

---$addToSet  ill add only non duplicate data

db.users.updateOne({
    name:"Maria"
},{
    $addToSet:{
        hobbies:{
            title:"hiking",
            frequency:2
        }
    }
})

db.users.updateOne({
    name:"Maria"
},{
    $addToSet:{
        hobbies:{
            title:"boating",
            frequency:2
        }
    }
})
