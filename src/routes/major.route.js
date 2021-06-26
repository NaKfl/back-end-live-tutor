import majorController from 'controllers/major.controller';
import express from 'express';

const router = express.Router();

router.get('/', majorController.getAll);

export default router;
