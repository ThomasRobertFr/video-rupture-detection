function C = findC(Ms, p)

C = norminv(1 - p, mean(Ms), std(Ms));