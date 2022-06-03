--insert persons.json
--password git:Savi@git12 and username:17euec135@skcet.ac.in
--after use git clone to import data from data base of contactData and collection of contacts (-d database and -c collection) we can create our on database and collection
mongoimport persons.json -d contactData -c contacts --jsonArray

use contactData

db.contacts.findOne()

db.contacts.find(
    {
        "dob.age":{
            $gt:60
        }
    }
).pretty()

db.contacts.find(
    {
        "dob.age":{
            $gt:60
        }
    }
).count()

---using explain()
db.contacts.explain().find(
    {
        "dob.age":{
            $gt:60
        }
    }
)

db.contacts.explain("executionStats").find(
    {
        "dob.age":{
            $gt:60
        }
    }
)

---create first  index  on age field

---db.collectionname.createIndex({"dob.age":1})

db.contacts.createIndex({"dob.age":1})

---dropping index

--db.collectionname.dropIndex()
db.contacts.dropIndex({"dob.age":1})

db.contacts.createIndex({gender:1})

db.contacts.explain("executionStats").find(
    {
        gender:"male"
    }
)

db.contacts.dropIndex({gender:1})

db.contacts.createIndex({"dob.age":1,gender:1})

db.contacts.explain("executionStats").find(
    {
        "dob.age":35,
        gender:"male"
    }
)

db.contacts.explain("executionStats").find(  --uses index scan
    {
        "dob.age":35
    }
)
--it perform left to right
db.contacts.explain("executionStats").find(  --uses default collscan
    {
        gender:"male"
    }
)

--using indees for sorting

db.contacts.explain().find({"dob.age":35}).sort({gender:1})

--list indexes

db.contacts.getIndexes()

db.contacts.findOne()


db.contacts.createIndex({email:1},{unique:true})  ---no duplicate email document 

 db.contacts.createIndex({email:1},{unique:true})
{
        "ok" : 0,
        "errmsg" : "E11000 duplicate key error collection: contactData.contacts index: email_1 dup key: { : \"abigail.clark@example.com\" }",
        "code" : 11000,
        "codeName" : "DuplicateKey"
}

db.contacts.find({email:"abigail.clark@example.com"}).count()  --2 so only e are getting above error msg hen e use unique

--partial indexes

db.contacts.createIndex({"dob.age":1},{partialFilterExpression:{gender:"male"}})

db.contacts.find({"dob.age":{$gt:60}}).pretty()

db.contacts.explain().find({"dob.age":{$gt:60},gender:"male"})

---------------------------------------

db.users.insertMany(
    [
        {
            name:"venkat",email:"venkat@test.com"
        },
         {
            name:"Snuti"
        }
    ]
)

db.users.createIndex({email:1})

db.users.dropIndex({email:1})

db.users.createIndex({email:1},{unique:true})

db.users.insertOne({        --duplicate error
    name:"Snuti"
})

db.users.dropIndex({email:1})

db.users.createIndex({email:1},{unique:true,partialFilterExpression:{email:{$exists:true}}})

db.users.insertOne({     name:"Snuti" })

db.users.find().pretty()

db.users.insertOne(
    
        {
            name:"venkat",email:"venkat@test.com"
        }
)

---TTL (Time To Live)

db.sessions.insertOne({
    data:"Just a message",
    createAt:new Date()
})

db.sessions.find().pretty()

 db.sessions.createIndex({createAt:1})

 db.sessions.dropIndex({createAt:1})


--session data will cleared after particular seconds
 db.sessions.createIndex(
     {createAt:1},
     {expireAfterSeconds:10}
     )

--Query Diagnosis &query planning

explain()
        "queryPlanner":
            shos summary for excuted query+ winning Plan
        "executionStats":
            show detailed summary for Executed Query+ winning plan+possibly Rejected plans
        "allPlansExecution":
            shows detailed summary of 
            Executed Query+ winning plan+winning plan decision process


--covered queries

db.customers.insertMany([
    {
        name:"venat",age:32,salary:32900
    },
     {
        name:"Manu",age:45,salary:4000
     }
])

db.customers.createIndex({name:1})

db.customers.explain("executionStats").find({name:"venat"})

db.customers.explain("allPlansExecution").find({name:"venat"})

---------------------------------------------------------------
--ho mongo rejects a plan

db.customers.getIndexes()

db.customers.createIndex({age:1,name:1})

db.customers.explain().find({name:"venat",age:32})

db.customers.explain("allPlansExecution").find({name:"venat",age:32})

db.customers.explain().find({age:32,name:"venat"})

db.customers.explain("allPlansExecution").find({age:32,name:"venat"})

--cleaning the winning plan from catch

/*stored forever?
    write threshold (curretly 10)
    when indexes are rebuild 
    other indexes are added or removed
    Mongo db server restored
    */