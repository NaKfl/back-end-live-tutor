import 'dotenv/config'
import express from 'express'
import cors from 'cors'
import routes from 'routes'
import { sequelize } from './database/models'

//Database
// const db = require('./config/database')

//Test DB
// db.authenticate()
//   .then(() => console.log('Database connected...'))
//   .catch((err) => console.log('Error: ' + err))

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
app.use('/api', routes.student)

const PORT = process.env.PORT || 5000
const useApp = async (port) => {
  await sequelize.authenticate().then(() => {
    console.log('Connected database')
    app.listen(port, () => {
      console.log(`Server is starting on port ${port}`)
    })
  })
}
useApp(PORT)
