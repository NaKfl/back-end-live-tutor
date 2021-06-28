'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Topic extends Model {
    static associate(models) {
      this.belongsTo(models.Course, {
        foreignKey: 'courseId',
        as: 'course',
      });
    }
  }
  Topic.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      courseId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'Course',
          key: 'id',
        },
      },
      orderCourse: DataTypes.INTEGER,
      name: DataTypes.TEXT,
      nameFile: DataTypes.TEXT,
      description: DataTypes.TEXT,
      videoUrl: DataTypes.TEXT,
    },
    {
      sequelize,
      modelName: 'Topic',
    },
  );
  return Topic;
};
