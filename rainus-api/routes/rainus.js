const express = require('express');
const router = express.Router();
const rainus = require('../services/rainus');

/* GET rainuss. */
router.get('/', async function(req, res, next) {
  try {
    res.json(await rainus.getMultiple(req.query.page));
  } catch (err) {
    console.error(`Error while getting rainuss`, err.message);
    next(err);
  }
});

/* POST rainus */
router.post('/', async function(req, res, next) {
  try {
    res.json(await rainus.create(req.body));
  } catch (err) {
    console.error(`Error while creating rainus`, err.message);
    next(err);
  }
});

/* PUT rainus */
router.put('/:id', async function(req, res, next) {
  try {
    res.json(await rainus.update(req.params.id, req.body));
  } catch (err) {
    console.error(`Error while updating rainus`, err.message);
    next(err);
  }
});

/* DELETE rainus */
router.delete('/:id', async function(req, res, next) {
  try {
    res.json(await rainus.remove(req.params.id));
  } catch (err) {
    console.error(`Error while deleting rainus`, err.message);
    next(err);
  }
});

module.exports = router;
