import catchAsync from 'utils/catchAsync';
import { tutorService, favoriteService } from 'services';

const tutorController = {};

tutorController.getMany = catchAsync(async (req, res) => {
  const { query, user } = req;
  const tutors = await tutorService.getMany(query);
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
  console.log({ avatar, video });
  const result = await tutorService.createWithUserId(
    { ...req.body },
    req?.user?.id,
    avatar,
    video,
  );
  res.send(result);
});

tutorController.getOne = catchAsync(async (req, res) => {
  const { id } = req.params;
  const result = await tutorService.getOne(id);
  res.send(result);
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

export default tutorController;
