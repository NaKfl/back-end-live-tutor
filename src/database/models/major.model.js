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
      key: DataTypes.STRING,
      englishName: DataTypes.TEXT,
      vietnameseName: DataTypes.TEXT,
      createdAt: DataTypes.DATE,
      updatedAt: DataTypes.DATE,
    },
    {
      sequelize,
      modelName: 'Major',
    },
  );
  return Major;
};
