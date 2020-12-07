require('dotenv/config')
const express = require('express')
const cors = require('cors')
const routes = require('./routes')

//Database
const db = require('./config/database')
// Test DB
db.authenticate()
  .then(() => console.log('Database connected...'))
  .catch((err) => console.log('Error: ' + err))

const app = express()
//Application-level-middleware
app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(cors())

// Function-level-middleware
app.use((req, res, next) => {
  //Handle logic
  next()
})

//Route
app.use('/gigs', routes.gigs)

const PORT = process.env.PORT || 5000
app.listen(PORT, () => {
  console.log(`Server is starting on port ${PORT}`)
})
