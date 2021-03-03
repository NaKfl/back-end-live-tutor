import express from 'express';
import morgan from 'morgan';
import bodyParser from 'body-parser';
import helmet from 'helmet';
import cors from 'cors';
import passport from 'passport';
import {
  jwtStrategy,
  facebookStrategy,
  googleStrategy,
} from 'configs/passport';
import { logs } from 'configs/vars';
import routes from 'routes';
import {
  errorConverter,
  errorHandler,
  notFoundHandler,
} from 'middlewares/error';

const app = express();

app.use(morgan(logs));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(helmet());

app.use(cors());
app.options('*', cors());

app.use(passport.initialize());
passport.use('jwt', jwtStrategy);
passport.use('facebook', facebookStrategy);
passport.use('google', googleStrategy);

app.use('/', routes);

app.use(notFoundHandler);

app.use(errorConverter);

app.use(errorHandler);

export default app;
