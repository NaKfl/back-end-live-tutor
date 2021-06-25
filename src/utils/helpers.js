import moment from 'moment';
import {
  DATE_TIME_FORMAT_YY_MM_HH_MM_SS,
  TRANSACTION_TYPES,
} from 'utils/constants';

export const getIncomeOutCome = (history) => {
  if (!history || !history.length) {
    return { total: 0, income: 0, outcome: 0 };
  }
  const result = history.reduce(
    (acc, curr) => {
      const total = acc.total + +curr.price;
      if (+curr.price < 0)
        return {
          ...acc,
          statistics: [
            ...acc.statistics,
            {
              total,
              time: moment(curr.createdAt).format(
                DATE_TIME_FORMAT_YY_MM_HH_MM_SS,
              ),
            },
          ],
          income:
            curr.type === TRANSACTION_TYPES.RETURN
              ? acc.income + +curr.price
              : acc.income,
          outcome:
            curr.type === TRANSACTION_TYPES.RETURN
              ? acc.outcome
              : acc.outcome + +curr.price,
          total,
        };
      if (+curr.price > 0)
        return {
          ...acc,
          statistics: [
            ...acc.statistics,
            {
              total,
              time: moment(curr.createdAt).format(
                DATE_TIME_FORMAT_YY_MM_HH_MM_SS,
              ),
            },
          ],
          income:
            curr.type === TRANSACTION_TYPES.CANCEL
              ? acc.income
              : acc.income + +curr.price,
          outcome:
            curr.type === TRANSACTION_TYPES.CANCEL
              ? acc.outcome + +curr.price
              : acc.outcome,
          total,
        };
      return acc;
    },
    {
      total: 0,
      income: 0,
      outcome: 0,
      statistics: [
        {
          total: 0,
          time: '',
        },
      ],
    },
  );

  result.statistics = result.statistics.reduce((acc, curr, idx, arr) => {
    if (curr?.time === arr[idx + 1]?.time) {
      return acc;
    }
    acc.push(curr);
    return acc;
  }, []);

  return result;
};
