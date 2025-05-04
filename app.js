import express from "express";
import 'dotenv/config'
import cors from 'cors';
import { expressjwt } from "express-jwt";
import ossRoute from './controller/ossRoute.js'
import mailRoute from './controller/mailRoute.js'
import userRoute from './controller/userRoute.js'
express()
  .use(cors({
    origin: ['http://localhost', 'http://localhost:5173', process.env.CLIENT_URL],
    credentials: true,
    allowedHeaders: ['Content-Type', 'Authorization', 'Accept', 'X-Requested-With'],
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    preflightContinue: true,
    maxAge: 86400,
    optionsSuccessStatus: 204
  }))
  .use(express.json())
  .use(express.urlencoded({ extended: true }))
  .use(expressJWT({
    secret: secretKey,
    algorithms: ["HS256"],
  }).unless({
    path: [
      /^\/api\/login/,
      /^\/api\/logout/,
      { url: /\/public/, methods: ["GET"] }
    ]
  }))
  .use('/api/', ossRoute)
  .use('/api/', mailRoute)
  .use('/api/', userRoute)
  .listen(process.env.SERVER_PORT, () => { console.log(`server ready on ${process.env.SERVER_PORT}`); });
