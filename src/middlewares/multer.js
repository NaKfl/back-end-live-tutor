import multer from 'multer';
import path from 'path';
import fs from 'fs';
import ApiError from 'utils/ApiError';
import { ERROR_CODE } from 'utils/constants';
import logger from 'configs/logger';

const dirUpload = path.join(__dirname, '../uploads');
const dirAvatar = path.join(__dirname, '../uploads/avatar');
const dirVideo = path.join(__dirname, '../uploads/video');
const dirTemp = path.join(__dirname, '../uploads/temp');

function ensureExists(path, mask, cb) {
  if (typeof mask == 'function') {
    // allow the `mask` parameter to be optional
    cb = mask;
    mask = 0o777;
  }
  fs.mkdir(path, mask, function (err) {
    if (err) {
      if (err.code == 'EEXIST') cb(null);
      else cb(err); // something else went wrong
    } else cb(null); // successfully created folder
  });
}
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    ensureExists(dirUpload, 0o744, function (err) {
      if (err) {
        logger.error(err);
      }
    });
    const fieldname = file.fieldname;
    if (fieldname === 'avatar') {
      ensureExists(dirAvatar, { recursive: true }, function (err) {
        if (err) {
          logger.error(err);
        } else {
          cb(null, dirAvatar);
        }
      });
    } else if (fieldname === 'video') {
      ensureExists(dirVideo, { recursive: true }, function (err) {
        if (err) {
          logger.error(err);
        } else {
          cb(null, dirVideo);
        }
      });
    } else {
      ensureExists(dirTemp, { recursive: true }, function (err) {
        if (err) {
          logger.error(err);
        } else {
          cb(null, dirTemp);
        }
      });
    }
  },
  filename: function (req, file, cb) {
    const user = req.user?.id;
    if (file.fieldname === 'avatar' || file.fieldname === 'video') {
      const typeImage = file.originalname.split('.')[1];
      const uniqueSuffix = '.' + typeImage;
      cb(null, user + file.fieldname + new Date().getTime() + uniqueSuffix);
    } else {
      cb(null, user + file.fieldname + file.originalname);
    }
  },
});

const upload = multer({
  storage: storage,
  fileFilter: function (req, file, cb) {
    if (file.fieldname === 'avatar') {
      const fileTypes = /\.(gif|jpe?g|tiff?|png|webp|bmp)$/i;
      const mimetype = fileTypes.test(file.originalname);
      if (mimetype) {
        return cb(null, true);
      }
    } else if (file.fieldname === 'video') {
      const fileTypes = /\.(mp4|mov|wmv|mkv|flv|avi)$/i;
      const mimetype = fileTypes.test(file.originalname);
      if (mimetype) {
        return cb(null, true);
      }
    }
    cb(
      new ApiError(
        ERROR_CODE.FILE_TYPE_NOT_SUPPORT.code,
        ERROR_CODE.FILE_TYPE_NOT_SUPPORT.message,
      ),
    );
  },
  limits: 1024 * 1024 * 3,
});

export default upload;
