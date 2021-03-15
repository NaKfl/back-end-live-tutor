'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class TutorFeedback extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'secondId',
        as: 'secondInfo',
      });
    }
  }
  TutorFeedback.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      firstId: DataTypes.UUID,
      secondId: DataTypes.UUID,
      rating: {
        type: DataTypes.FLOAT,
        defaultValue: '5',
      },
      content: DataTypes.TEXT,
    },
    {
      sequelize,
      modelName: 'TutorFeedback',
    },
  );
  return TutorFeedback;
};
