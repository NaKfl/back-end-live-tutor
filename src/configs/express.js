import express from 'express';
import morgan from 'morgan';
import bodyParser from 'body-parser';
import helmet from 'helmet';
import cors from 'cors';
import { logs } from 'configs/vars';
import routes from 'routes';

const app = express();

app.use(morgan(logs));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(helmet());

app.use(cors());

// Function-level-middleware
app.use((req, res, next) => {
  //Handle logic
  next();
});

app.use('/', routes);

export default app;
