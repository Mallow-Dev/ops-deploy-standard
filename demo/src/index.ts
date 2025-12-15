import express from 'express';

export const app = express();
const port = process.env.PORT ? Number(process.env.PORT) : 3000;

app.get('/', (req, res) => {
  res.json({ ok: true, env: { NODE_ENV: process.env.NODE_ENV || 'dev' } });
});

if (process.env.NODE_ENV !== 'test') {
  app.listen(port, () => console.log(`Demo server listening on ${port}`));
}
