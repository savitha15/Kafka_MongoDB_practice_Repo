use user
db.users.find().pretty()

db.users.updateOne({_id: ObjectId("6271d9b07b1b6eabba8bc9ba")},{$set:{
    hobbies:[{
        title:"Sports",
        frequency:5
    },
    {
        title:"playing",
        frequency:3
    },
    {
        title:"hiking",
        frequency:1
    }]
}})

db.users.updateOne(
    {_id:ObjectId("626f47686d2c915fab0837cd")},
    {
        $set:{name:"kavi",
        hobbies:[
            {
                title:"planting",
                frequency:3
            },
            {
                title:"painting",
                frequency:6
            }
        ]
    }
})

db.users.updateMany(
    {"hobbies.title":"Sports"},{
        $set:{isSporty:true}
    }
    )

--update phne number for krish
    db.users.updateOne({_id: ObjectId("6271d9b07b1b6eabba8bc9ba")},{$set:{
   age:40,
   phone:7245099634
}})

--increment age by 2
 db.users.updateOne({name:"savi"},
 {
    $inc:{age:2}
 }
 )

 --decrement age by -2
 db.users.updateOne({name:"savi"},
 {
    $inc:{age:-2}
 }
 )

-- multiple operations on savi document
 db.users.updateOne({name:"savi"},
 {
    $inc:{age:1},
    $set:{isSporty:true}
 }
 )

-- we cannot increment and set the same field 
 db.users.updateOne({name:"savi"},
 {
    $inc:{age:1},
    $set:{age:69}
 }
 )

--min it will update the value if the updated value should be lesser than the original value

db.users.updateOne({name:"krish"},
 {$min:{age:35}
 })

--max 
 db.users.updateOne({name:"krish"},
 {$max:{age:40}
 })

--mul it multiplies the specified value
  db.users.updateOne({name:"krish"},
 {$mul:{age:5}
 })


--set phone null

db.users.updateMany({isSporty:true},{$set:{phone:null}})

--unset to remove the field completely

db.users.updateMany({isSporty:true},{$unset:{phone:null}})

--to rename the field age to totalage

db.users.updateMany({},{$rename:{age:"totalAge"}})


-----
use contactData
db.contacts.drop()

db.contacts.insertOne({
    name:"venkat",
    hobbies:["cooking","sports"],
    address:[
        {
            street:"main street",

        },
        {
            street:"second street"
        }
    ]
})

db.contacts.createIndex(
    {
        hobbies:1
    }
)

db.contacts.find(({hobbies:"sports"})).pretty()

db.contacts.explain("executionStats").find(({hobbies:"sports"}))

db.contacts.createIndex(
    {
        address:1
    }
)

db.contacts.explain("executionStats").find(({"address.street":"main street"}))   --collscan

db.contacts.explain("executionStats").find({
    address:{
        street:"main street"
    }}
)

---multiindex
db.contacts.createIndex({
    name:1,
    hobbies:1
})

----cannot create index for two arrays
db.contacts.createIndex({
    
    hobbies:1,
    address:1,
})

---text indexes

db.products.insertMany([
    {
        title:"A Book",
        description:"This is an awesome book for all people"
    },
    {
        title:"T-Shirt",
        description:"This T-Shirt is cool"
    }
])

db.products.createIndex(({description:1}))
db.products.dropIndex(({description:1}))


 db.products.createIndex(({description:"text"}))

db.products.find({
    $text:{
        $search: "is"
    }
}).pretty()

db.products.find({
    $text:{
        $search: "cool"
    }
}).pretty()

db.products.find({
    $text:{
        $search: "awesome T-Shirt"
    }
}).pretty()

---getting red book but no one is here
db.products.find({
    $text:{
        $search: "\"awesome T-Shirt\""
    }
}).pretty()

db.products.find({
    $text:{
        $search: "\"awesome book\""
    }
}).pretty()

----match all docs,add score, sort by score


db.products.find({
    $text:{
        $search: "awesome t-shirt"
    }
}).pretty()

db.products.find({
    $text:{
        $search: "awesome t-shirt"
    }
},
{
    score:{
        $meta:"textScore"
    }
}).pretty()

db.products.getIndexes()

 db.products.dropIndex("description_text")

 db.products.createIndex({
     title:"text",
     description:"text"
 })

 db.products.insertOne({
     title:"A ship",
     description:"Floats perfectly!"
 })

 db.products.find({
    $text:{
        $search: "ship"
    }
}).pretty()


----to exclude cool from 
db.products.find({
    $text:{                         --not working
        $search: "is -cool"
    }
}).pretty()

db.products.getIndexes()
db.products.dropIndex("title_text_description_text")

db.products.createIndex({
    title:"text",
    description:"text"
},{
    default_language:"english",
    weights:{
        title: 1,
        description:10
    }
})

db.products.find({
    $text:{
        $search:"cool",
       
    }
},{
    score:{
        $meta:"textScore"
    }
})

