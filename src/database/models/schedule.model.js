'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Schedule extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'tutorId',
        as: 'tutorInfo',
      });
    }
  }
  Schedule.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      tutorId: DataTypes.UUID,
      date: { type: DataTypes.DATE },
      startTime: { type: DataTypes.DATE },
      endTime: { type: DataTypes.DATE },
      createdAt: { type: DataTypes.DATE, defaultValue: new Date() },
      updatedAt: { type: DataTypes.DATE, defaultValue: new Date() },
    },
    {
      sequelize,
      modelName: 'Schedule',
    },
  );
  return Schedule;
};
