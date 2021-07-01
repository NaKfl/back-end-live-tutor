import moment from 'moment';
import fs from 'fs';
import { MAX_AVATAR_SIZE, MAX_VIDEO_SIZE } from './constants';

export const pick = (object, keys) => {
  if (!keys) return object;
  return keys.reduce((obj, key) => {
    if (object && key in object) {
      obj[key] = object[key];
    }
    return obj;
  }, {});
};

export const exclude = (object, keys) => {
  if (!keys) return object;
  return Object.keys(object.dataValues).reduce((obj, key) => {
    if (object && !keys.includes(key)) {
      obj[key] = object[key];
    }
    return obj;
  }, {});
};

export const flatObjectsByKeys = (objects, flattedKeys) => {
  return objects.map((obj) => {
    for (const [key, value] of Object.entries(obj)) {
      if (flattedKeys.includes(key)) {
        delete obj[key];
        obj = { ...obj, ...value };
      }
    }
    return obj;
  });
};

export const excludeUndefined = (field) => {
  const where = Object.keys(field).reduce((pre, now) => {
    if (typeof field[now] === 'undefined') return { ...pre };
    return Object.assign(pre, { [now]: field[now] });
  }, {});
  return where;
};

export const getProtocol = (req) => {
  let proto = req.connection.encrypted ? 'https' : 'http';
  proto = req.headers['x-forwarded-proto'] || proto;
  return proto.split(/\s*,\s*/)[0];
};

export const includeArray = (superset, subset) => {
  if (0 === subset.length) {
    return false;
  }
  return subset.every(function (value) {
    return superset.indexOf(value) >= 0;
  });
};

export const stringDate = (miliseconds) => {
  let during = moment.duration(miliseconds);
  const days = during.days();
  const hours = during.hours();
  const minutes = during.minutes();
  const seconds = during.seconds();
  let strDates = '';
  if (days > 0) {
    strDates = strDates + days + ' days ';
  }
  if (hours > 0) {
    strDates = strDates + hours + ' hours ';
  }
  if (minutes > 0) {
    strDates = strDates + minutes + ' minutes ';
  }
  if (seconds > 0) {
    strDates = strDates + seconds + ' seconds ';
  }
  return strDates;
};

export const unLinkPath = (path) => {
  fs.unlinkSync(path);
};

export const getFullPathUrl = (req) => {
  return req.protocol + '://' + req.get('host');
};

export const isOverThanLimitSize = (file) => {
  if (file.fieldname === 'avatar') {
    if (file?.size <= MAX_AVATAR_SIZE) return false;
  } else if (file.fieldname === 'video') {
    if (file?.size <= MAX_VIDEO_SIZE) return false;
  }
  return true;
};
