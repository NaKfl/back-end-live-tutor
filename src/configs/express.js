import http from 'http';
import express from 'express';
import morgan from 'morgan';
import helmet from 'helmet';
import cors from 'cors';
import passport from 'passport';
import adapter from 'socket.io-redis';
import {
  jwtStrategy,
  facebookStrategy,
  googleStrategy,
} from 'configs/passport';
import socketio from 'socket.io';
import {
  logs,
  redis as redisVars,
  CLIENT_URL,
  SERVER_URL,
  ADMIN_URL,
} from 'configs/vars';
import logger from 'configs/logger';
import initSockets from 'sockets';
import routes from 'routes';
import {
  errorConverter,
  errorHandler,
  notFoundHandler,
} from 'middlewares/error';
import path from 'path';

const app = express();

app.use(helmet());
app.use(morgan(logs, { stream: logger.stream }));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(__dirname));

app.use(
  cors({
    origin: [ADMIN_URL, CLIENT_URL, SERVER_URL],
  }),
);

app.use(passport.initialize());
passport.use('jwt', jwtStrategy);
passport.use('facebook', facebookStrategy);
passport.use('google', googleStrategy);

app.use('/apidoc', express.static('src/apidoc/dist'));
app.use('/banks', express.static('src/public/banks'));
app.use('/pdf', express.static(path.join(__dirname, '/../uploads/pdf')));
app.use('/avatar', express.static(path.join(__dirname, '/../uploads/avatar')));
app.use('/video', express.static(path.join(__dirname, '/../uploads/video')));

app.use('/', routes);

app.use(notFoundHandler);

app.use(errorConverter);

app.use(errorHandler);

const server = http.createServer(app);

const io = socketio(server, {
  cors: {
    origin: [ADMIN_URL, CLIENT_URL, SERVER_URL],
    methods: ['GET', 'POST'],
    credentials: true,
  },
  transports: ['websocket', 'polling'],
});

const redisAdapter = adapter({
  host: redisVars.host,
  port: redisVars.port,
});

io.adapter(redisAdapter);
initSockets(io);

export default server;
