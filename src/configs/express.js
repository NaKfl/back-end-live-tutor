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
import path from 'path';

const app = express();

app.use(morgan(logs));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(__dirname));
app.use(helmet());

app.use(cors());
app.options('*', cors());

app.use(passport.initialize());
passport.use('jwt', jwtStrategy);
passport.use('facebook', facebookStrategy);
passport.use('google', googleStrategy);
// app.use(express.static(path.join(__dirname, '/../uploads')));
app.use('/avatar', express.static(path.join(__dirname, '/../uploads/avatar')));
app.use('/video', express.static(path.join(__dirname, '/../uploads/video')));
//*custom
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header(
    'Access-Control-Allow-Headers',
    'x-www-form-urlencoded, Origin, X-Requested-With, Content-Type, Accept, Authorization, *',
  );
  if (req.method === 'OPTIONS') {
    res.header(
      'Access-Control-Allow-Methods',
      'GET, PUT, POST, PATCH, DELETE, OPTIONS',
    );
    res.setHeader('Access-Control-Allow-Credentials', true);
    return res.status(200).json({});
  }
  next();
});
// Function-level-middleware
app.use((req, res, next) => {
  //Handle logic
  next();
});

app.use('/', routes);

app.use(notFoundHandler);

app.use(errorConverter);

app.use(errorHandler);

export default app;
