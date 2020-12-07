const {Router} = require('express')
const router = Router()
const db = require('../config/database')
const Gig = require('../models/gig')

router.get('/', async (req, res) => {
  try {
    const Gigs = await Gig.findAll()
    console.log(Gigs)
    res.sendStatus(200)
  } catch (err) {
    console.log(err)
    res.sendStatus(400)
  }
})

router.get('/:gigId', (req, res) => {
  return res.send('Get gig')
})

router.post('/', (req, res) => {
  return res.send('Post gig')
})

router.put('/:gigId', (req, res) => {
  return res.send('Put gig')
})

router.patch('/:gigId', (req, res) => {
  return res.send('Patch gig')
})

router.delete('/:gigId', (req, res) => {
  return res.send('Delete gig')
})

module.exports = router
