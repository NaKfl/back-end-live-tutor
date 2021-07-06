'use strict';

const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Course extends Model {
    static associate(models) {
      this.hasMany(models.Topic, {
        foreignKey: 'courseId',
        as: 'topics',
      });
      this.belongsToMany(models.User, {
        through: models.TutorCourse,
        as: 'users',
      });
    }
  }

  Course.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      name: DataTypes.TEXT,
      description: DataTypes.TEXT,
      imageUrl: DataTypes.TEXT,
      level: DataTypes.TEXT,
      reason: DataTypes.TEXT,
      purpose: DataTypes.TEXT,
      other_details: DataTypes.TEXT,
      default_price: DataTypes.FLOAT,
      course_price: DataTypes.FLOAT,
    },
    {
      sequelize,
      modelName: 'Course',
    },
  );

  return Course;
};
