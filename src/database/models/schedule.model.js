'use strict';
const { Model } = require('sequelize');
const moment = require('moment');

module.exports = (sequelize, DataTypes) => {
  class Schedule extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'tutorId',
        as: 'tutorInfo',
      });
      this.hasMany(models.ScheduleDetail, {
        foreignKey: 'scheduleId',
        as: 'scheduleDetailInfo',
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
      date: {
        type: DataTypes.DATEONLY,
        get: function () {
          return moment(this.getDataValue('date')).format('YYYY-MM-DD');
        },
      },
      startTime: {
        type: DataTypes.STRING,
      },
      endTime: {
        type: DataTypes.STRING,
      },
      createdAt: DataTypes.DATE,
      updatedAt: DataTypes.DATE,
    },
    {
      sequelize,
      modelName: 'Schedule',
    },
  );
  return Schedule;
};
