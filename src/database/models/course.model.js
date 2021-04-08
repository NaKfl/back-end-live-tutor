'use strict';

const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Course extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'tutorId',
        as: 'tutorUser',
      });
      this.hasMany(models.Topic, {
        foreignKey: 'courseId',
        as: 'topics',
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
      tutorId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      name: DataTypes.TEXT,
      description: DataTypes.TEXT,
      imageUrl: DataTypes.TEXT,
      level: DataTypes.TEXT,
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
