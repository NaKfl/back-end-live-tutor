import {Router} from 'express'
import Gig from 'models/gig'

const router = Router()

router.get('/', async (req, res) => {
  try {
    const Gigs = await Gig.findAll()
    res.status(200)
    res.send(Gigs)
  } catch (err) {
    res.status(500)
    res.send(err)
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

export default router
