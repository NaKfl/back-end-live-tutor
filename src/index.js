import 'dotenv/config'
import express from 'express'
import cors from 'cors'
import routes from './routes'
import db from './config/database'

//Test DB
db.authenticate()
  .then(() => console.log('Database connected...'))
  .catch((err) => console.log('Error: ' + err))

//Express
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
