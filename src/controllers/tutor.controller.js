import catchAsync from 'utils/catchAsync';
import { tutorService, favoriteService, userService } from 'services';
import { ERROR_CODE, ROLES } from 'utils/constants';
import { getFullPathUrl, isOverThanLimitSize, unLinkPath } from 'utils/common';
import ApiError from 'utils/ApiError';

const tutorController = {};

tutorController.getMany = catchAsync(async (req, res) => {
  const { query } = req;
  const tutors = await tutorService.getMany(query);
  res.json({ tutors });
});

tutorController.getMore = catchAsync(async (req, res) => {
  const { query, user } = req;
  const tutors = await tutorService.getMore(query, user);
  const favoriteTutor = await favoriteService.getListFavoriteTutorById(user.id);
  res.json({ tutors, favoriteTutor });
});

tutorController.register = catchAsync(async (req, res) => {
  const files = req.files;
  let errorSizeLimit = {};
  Object.keys(files).forEach((key) => {
    const file = files[key][0];
    if (isOverThanLimitSize(file)) {
      errorSizeLimit[key] = true;
      unLinkPath(file.path);
    }
  });
  Object.keys(errorSizeLimit).forEach((key) => {
    if (errorSizeLimit[key] === true) {
      if (key === 'avatar') {
        throw new ApiError(
          ERROR_CODE.FILE_SIZE_OVER_LIMIT_AVATAR.code,
          ERROR_CODE.FILE_SIZE_OVER_LIMIT_AVATAR.message,
        );
      } else {
        throw new ApiError(
          ERROR_CODE.FILE_SIZE_OVER_LIMIT_VIDEO.code,
          ERROR_CODE.FILE_SIZE_OVER_LIMIT_VIDEO.message,
        );
      }
    }
  });

  const avatar =
    getFullPathUrl(req) +
    `/${files?.avatar[0]?.fieldname}/` +
    files?.avatar[0]?.filename;
  const video =
    getFullPathUrl(req) +
    `/${files?.video[0]?.fieldname}/` +
    files?.video[0]?.filename;
  const result = await tutorService.createWithUserId(
    { ...req.body },
    req?.user?.id,
    avatar,
    video,
  );
  await userService.createRole(req?.user?.id, ROLES.TUTOR);
  res.send(result);
});

tutorController.getOne = catchAsync(async (req, res) => {
  const { user } = req;
  const { id: tutorUserId } = req.params;
  let responseData = {};
  const { tutor, avgRating, price } = await tutorService.getOne(tutorUserId);
  if (tutor) {
    responseData = tutor.toJSON();
    const isFavorite = await tutorService.checkIsFavoriteTutorByUserId(
      user.id,
      tutorUserId,
    );
    responseData.isFavorite = isFavorite;
    responseData.avgRating = avgRating ? avgRating : 0;
    responseData.price = price;
  }
  res.send(responseData);
});

tutorController.updateOne = catchAsync(async (req, res) => {
  const files = req.files;
  let error = {};
  Object.keys(files).forEach((key) => {
    const file = files[key][0];
    if (isOverThanLimitSize(file)) {
      error[key] = true;
      unLinkPath(file.path);
    }
  });
  Object.keys(error).forEach((key) => {
    if (error[key] === true) {
      if (key === 'avatar') {
        throw new ApiError(
          ERROR_CODE.FILE_SIZE_OVER_LIMIT_AVATAR.code,
          ERROR_CODE.FILE_SIZE_OVER_LIMIT_AVATAR.message,
        );
      } else {
        throw new ApiError(
          ERROR_CODE.FILE_SIZE_OVER_LIMIT_VIDEO.code,
          ERROR_CODE.FILE_SIZE_OVER_LIMIT_VIDEO.message,
        );
      }
    }
  });

  const updatedData = { ...req.body };

  if (files?.avatar)
    updatedData.avatar =
      getFullPathUrl(req) +
      `/${files?.avatar[0]?.fieldname}/` +
      files?.avatar[0]?.filename;

  if (files?.video)
    updatedData.video =
      getFullPathUrl(req) +
      `/${files?.video[0]?.fieldname}/` +
      files?.video[0]?.filename;

  const data = await tutorService.updateOne(req?.user?.id, updatedData);

  res.json({ message: 'Update tutor info successfully', data });
});

tutorController.getWaitingList = catchAsync(async (req, res) => {
  const data = await tutorService.getWaitingList();
  res.json({ message: 'Success', data });
});

tutorController.acceptedTutor = catchAsync(async (req, res) => {
  const { body } = req;
  const data = await tutorService.acceptedTutor(body);
  res.json({ message: 'Success', data });
});

tutorController.scheduleRegister = catchAsync(async (req, res) => {
  const { user, body } = req;
  const data = await tutorService.scheduleRegister(user?.id, body);
  res.json({ message: 'Success', data });
});

tutorController.getListRankTutor = catchAsync(async (req, res) => {
  const { num } = req.params;
  const data = await tutorService.getListRankTutor(num);
  res.json({ message: 'Success', data });
});

tutorController.searchTutor = catchAsync(async (req, res) => {
  const { filters, search, page, perPage } = req.body;
  const result = await tutorService.searchWithFilter({
    filters,
    search,
    page,
    perPage,
  });
  res.send(result);
});

tutorController.accountingPerHour = catchAsync(async (req, res) => {
  const result = await tutorService.test(req.user.id);
  res.send(result);
});

tutorController.getDetailInAdmin = catchAsync(async (req, res) => {
  const { params } = req;
  const { id } = params;
  if (!id) {
    throw new Error('Must be contain id passed');
  }
  const result = await tutorService.getOneInAdmin(id);
  res.send(result);
});

tutorController.block = catchAsync(async (req, res) => {
  const { body } = req;
  const { id } = body;
  const result = await tutorService.block(id);
  res.send(result);
});
export default tutorController;
