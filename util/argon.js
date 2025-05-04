import argon2 from "argon2";
export const argonhash = async (password) => {
  const hash = await argon2.hash(password, {
    type: argon2.argon2id,
    timeCost: 3,
    memoryCost: 4096,
    parallelism: 1
  })
  return hash;
};

export const argonverify = async (password, hash) => {
  const isValid = await argon2.verify(hash, password);
  return isValid;
};
