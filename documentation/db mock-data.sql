INSERT INTO roles ("name", "inserted_at", "updated_at") VALUES
('Employee', now(), now()),
('Manager', now(), now()),
('General Manager', now(), now());

INSERT INTO users ("username", "email", "password", "role", "inserted_at", "updated_at") VALUES ('employee', 'employee@time.man', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('gmandrey0', 'rknowlson0@trellian.com', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('gblincowe2', 'abrugh2@gizmodo.com', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('ejephcote3', 'dbrick3@tmall.com', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('kjaher4', 'lchainey4@comcast.net', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('rdunkersley5', 'spheasey5@blinklist.com', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('kwallington6', 'owrotham6@phoca.cz', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('kfidilis7', 'jbeddow7@fotki.com', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('kpennrington8', 'kanselm8@lycos.com', 'FA5473530E4D1A5A1E1EB53D2FEDB10C', 1, now(), now()),
('mrunge9', 'dscotcher9@sohu.com', '1D0258C2440A8D19E716292B231E3190', 2, now(), now()),
('manager', 'manager@time.man', '1D0258C2440A8D19E716292B231E3190', 2, now(), now()),
('admin', 'admin@time.man', '21232F297A57A5A743894A0E4A801FC3', 3, now(), now());

INSERT INTO teams ("members", "name", "user_id", "inserted_at", "updated_at") VALUES
(ARRAY[1,2,3,4,5], 'toto', 11, now(), now()),
(ARRAY[7,8,9,4,5], 'tata', 10, now(), now()),
(ARRAY[1,2,3,7], 'best', 10, now(), now()),
(ARRAY[1,2,3], 'beast', 11, now(), now()),
(ARRAY[4,5], 'monster', 11, now(), now()),
(ARRAY[4,5,8], 'tutu', 11, now(), now());

INSERT INTO workingtimes ("start", "end", "user_id", "inserted_at", "updated_at") VALUES
('2020-10-23T08:00:00Z', '2020-10-23T15:00:00Z', 1, now(), now()),
('2020-10-24T08:00:00Z', '2020-10-24T15:00:00Z', 1, now(), now()),
('2020-10-25T08:00:00Z', '2020-10-25T18:00:00Z', 1, now(), now()),
('2020-10-26T08:00:00Z', '2020-10-26T16:00:00Z', 1, now(), now()),
('2020-10-27T08:00:00Z', '2020-10-27T12:00:00Z', 1, now(), now()),
('2020-10-28T08:00:00Z', '2020-10-28T20:00:00Z', 1, now(), now()),
('2020-10-29T08:00:00Z', '2020-10-29T15:00:00Z', 1, now(), now()),
('2020-10-24T08:00:00Z', '2020-10-24T15:00:00Z', 2, now(), now()),
('2020-10-24T12:00:00Z', '2020-10-25T18:00:00Z', 2, now(), now()),
('2020-10-26T08:00:00Z', '2020-10-26T14:00:00Z', 2, now(), now()),
('2020-10-26T20:20:00Z', '2020-10-27T02:00:00Z', 2, now(), now()),
('2020-10-28T08:00:00Z', '2020-10-28T15:00:00Z', 2, now(), now());

INSERT INTO clocks ("status", "time", "user_id", "inserted_at", "updated_at") values
(true, '2020-10-23T08:38:44Z', 1, now(), now()),
(false, '2020-10-23T15:38:44Z', 1, now(), now()),
(true, '2020-10-24T07:38:44Z', 1, now(), now()),
(false, '2020-10-24T14:38:44Z', 1, now(), now()),
(true, '2020-10-24T18:38:44Z', 1, now(), now()),
(false, '2020-10-24T20:38:44Z', 1, now(), now()),
(true, '2020-10-25T10:38:44Z', 1, now(), now()),
(false, '2020-10-25T20:38:44Z', 1, now(), now()),
(true, '2020-10-26T09:38:44Z', 1, now(), now()),
(false, '2020-10-26T14:38:44Z', 1, now(), now()),
(true, '2020-10-26T23:38:44Z', 1, now(), now()),
(false, '2020-10-27T08:38:44Z', 1, now(), now()),
(true, '2020-10-28T20:38:44Z', 1, now(), now()),
(false, '2020-10-29T05:38:44Z', 1, now(), now()),
(true, '2020-10-24T08:38:44Z', 2, now(), now()),
(false, '2020-10-24T18:38:44Z', 2, now(), now()),
(true, '2020-10-24T19:38:44Z', 2, now(), now()),
(false, '2020-10-25T01:38:44Z', 2, now(), now()),
(true, '2020-10-25T11:38:44Z', 2, now(), now()),
(false, '2020-10-25T18:38:44Z', 2, now(), now()),
(true, '2020-10-26T09:38:44Z', 2, now(), now()),
(false, '2020-10-26T14:38:44Z', 2, now(), now()),
(true, '2020-10-26T23:38:44Z', 2, now(), now()),
(false, '2020-10-27T08:38:44Z', 2, now(), now()),
(true, '2020-10-28T20:38:44Z', 2, now(), now()),
(false, '2020-10-29T05:38:44Z', 2, now(), now());
