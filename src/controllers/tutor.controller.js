import catchAsync from 'utils/catchAsync';
import { tutorService, favoriteService, userService } from 'services';
import { ROLES } from 'utils/constants';

const tutorController = {};

tutorController.getMany = catchAsync(async (req, res) => {
  const { query, user } = req;
  const tutors = await tutorService.search(query);
  const favoriteTutor = await favoriteService.getListFavoriteTutorById(user.id);
  res.json({ tutors, favoriteTutor });
});

tutorController.getMore = catchAsync(async (req, res) => {
  const { query, user } = req;
  const tutors = await tutorService.getMore(query, user);
  const favoriteTutor = await favoriteService.getListFavoriteTutorById(user.id);
  res.json({ tutors, favoriteTutor });
});

tutorController.register = catchAsync(async (req, res) => {
  const file = req.files;
  const avatar =
    'http://' +
    req.headers.host +
    `/${file?.avatar[0]?.fieldname}/` +
    file?.avatar[0]?.filename;
  const video =
    'http://' +
    req.headers.host +
    `/${file?.video[0]?.fieldname}/` +
    file?.video[0]?.filename;
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
  const { tutor, avgRating } = await tutorService.getOne(tutorUserId);
  if (tutor) {
    responseData = tutor.toJSON();
    const isFavorite = await tutorService.checkIsFavoriteTutorByUserId(
      user.id,
      tutorUserId,
    );
    responseData.isFavorite = isFavorite;
    responseData.avgRating = avgRating ? avgRating : 0;
  }
  res.send(responseData);
});

tutorController.getWaitingList = catchAsync(async (req, res) => {
  const data = await tutorService.getWaitingList();
  res.json({ message: 'Success', data });
});

tutorController.updateTutor = catchAsync(async (req, res) => {
  const { body } = req;
  await tutorService.updateTutor(body);
  const data = await tutorService.getOne(body.userId);
  res.json({ message: 'Success', data });
});

tutorController.scheduleRegister = catchAsync(async (req, res) => {
  const { user, body } = req;
  const data = await tutorService.scheduleRegister(user?.id, body);
  res.json({ message: 'Success', data });
});

tutorController.searchTutor = catchAsync(async (req, res) => {
  const { query, user } = req;
  const tutors = await tutorService.search(query);
  const favoriteTutor = await favoriteService.getListFavoriteTutorById(user.id);
  res.json({ tutors, favoriteTutor });
});

tutorController.getListRankTutor = catchAsync(async (req, res) => {
  const { num } = req.params;
  const data = await tutorService.getListRankTutor(num);
  res.json({ message: 'Success', data });
});

export default tutorController;
