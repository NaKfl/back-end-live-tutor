'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Major extends Model {
    static associate(models) {
      this.hasMany(models.SubMajor, {
        foreignKey: 'majorId',
        as: 'subMajors',
      });
    }
  }
  Major.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      englishName: DataTypes.TEXT,
      vietnameseName: DataTypes.TEXT,
      createdAt: { type: DataTypes.DATE, defaultValue: new Date() },
      updatedAt: { type: DataTypes.DATE, defaultValue: new Date() },
    },
    {
      sequelize,
      modelName: 'Major',
    },
  );
  return Major;
};
