'use strict';

const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class TutorCourse extends Model {
    // static associate(models) {}
  }

  TutorCourse.init(
    {
      UserId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'Users',
          key: 'id',
        },
      },
      CourseId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'Courses',
          key: 'id',
        },
      },
    },
    {
      sequelize,
      modelName: 'TutorCourse',
    },
  );

  return TutorCourse;
};
