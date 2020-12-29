import app from 'configs/express';
import request from 'supertest';
import httpStatus from 'http-status';

describe('GET /status', () => {
  test('should return message "OK"', () => {
    return request(app)
      .get('/status')
      .expect(httpStatus.OK)
      .then((res) => {
        const { message } = res.body;
        expect(message).toBe('OK');
      });
  });
});
