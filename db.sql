--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: exercise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE exercise (
    e_id integer NOT NULL,
    name text NOT NULL,
    description text,
    image text[],
    muscle character varying[],
    muscle_secondary character varying[],
    category integer
);


ALTER TABLE exercise OWNER TO postgres;

--
-- Name: exercise_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE exercise_category (
    ec_id integer NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE exercise_category OWNER TO postgres;

--
-- Name: program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE program (
    p_id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE program OWNER TO postgres;

--
-- Name: program_p_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE program_p_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE program_p_id_seq OWNER TO postgres;

--
-- Name: program_p_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE program_p_id_seq OWNED BY program.p_id;


--
-- Name: training_day; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE training_day (
    td_id integer NOT NULL,
    p_id integer NOT NULL,
    name text NOT NULL,
    exercises integer[]
);


ALTER TABLE training_day OWNER TO postgres;

--
-- Name: training_day_td_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE training_day_td_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE training_day_td_id_seq OWNER TO postgres;

--
-- Name: training_day_td_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE training_day_td_id_seq OWNED BY training_day.td_id;


--
-- Name: training_result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE training_result (
    tr_id integer NOT NULL,
    td_id integer NOT NULL,
    e_id integer NOT NULL,
    trained_on date,
    rep_count integer NOT NULL,
    weight integer
);


ALTER TABLE training_result OWNER TO postgres;

--
-- Name: training_result_tr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE training_result_tr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE training_result_tr_id_seq OWNER TO postgres;

--
-- Name: training_result_tr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE training_result_tr_id_seq OWNED BY training_result.tr_id;


--
-- Name: program p_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY program ALTER COLUMN p_id SET DEFAULT nextval('program_p_id_seq'::regclass);


--
-- Name: training_day td_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY training_day ALTER COLUMN td_id SET DEFAULT nextval('training_day_td_id_seq'::regclass);


--
-- Name: training_result tr_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY training_result ALTER COLUMN tr_id SET DEFAULT nextval('training_result_tr_id_seq'::regclass);


--
-- Data for Name: exercise; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY exercise (e_id, name, description, image, muscle, muscle_secondary, category) FROM stdin;
350	Aalex Gambe Alte al Muro	<p></p>\n<p>60 secondi per ogni stazione, ripetere tutto 2 volte</p>\n<p>1. gambe alte ferme, cercando di portare i glutei più vicino possibile al muro</p>\n<p>2. portare la gamba destra "ad ore 3", quanto più largo possibile; la gamba sinistra è ferma in alto</p>\n<p>3. portare la gamba sinistra "ad ore 9", quanto più largo possibile; la gamba destra è ferma in alto</p>\n<p>4. partendo da posizione base, allargare entrabe le gambe il più possibile (per raggiungere le "10 e 10")</p>\n<p>5. gambe piegate a rana e piedi appoggiati al muro (il lato destro del piede destro, per capirci, tocca il muro, viceversa per il sinistro): spingere con le mani in zona ginocchia verso il muro per avvicinarle</p>	{}	{}	{}	9
98	Butterfly	<p>Sit on the butterfly machine, the feet have a good contact with the floor, the upper arms are parallel to the floor. Press your arms together till the handles are practically together (but aren't!). Go slowly back. The weights should stay all the time in the air.</p>	{https://wger.de/media/exercise-images/98/Butterfly-machine-2.png,https://wger.de/media/exercise-images/98/Butterfly-machine-1.png}	{"Pectoralis major"}	{"Anterior deltoid"}	11
87	Dumbbells on Scott Machine		{}	{"Biceps brachii"}	{}	8
160	Pistol Squat	<p>One legged squat</p>	{}	{"Gluteus maximus","Biceps femoris"}	{"Biceps brachii","Anterior deltoid",Brachialis}	9
161	Rack Deadlift	<p>Deadlift to be done using a Smith machine or a free rack. Bar or barbell hould be just right under the knee cap level. Lift using the glutes and through the heels, then come back to starting postion with a control movement of 2 seconds.</p>\n<p>This exercise targets mainly the lower back and glutes.</p>	{https://wger.de/media/exercise-images/161/Dead-lifts-2.png,https://wger.de/media/exercise-images/161/Dead-lifts-1.png}	{"Gluteus maximus"}	{"Biceps brachii"}	12
216	Straight-arm Pull Down (bar Attachment)	<p>Use the straight bar attachment on a high pulley. Grasp the two ends of the bar with your palms facing downward and your arms straight out in front of you. Pull your hands down towards your hips, while keeping your arms straight, then raise them back up to the starting position.</p>	{}	{"Latissimus dorsi"}	{"Triceps brachii"}	12
147	Upright Row, on Multi Press	<p>The movements are basically the same as with an SZ-bar, but you use the bar on the multi press:</p>\n<p>Stand straight, your feet are shoulder-width apart. Hold the bar with an overhand grip on your thighs, the arms are stretched. Lift the bar close to the body till your chin. The elbows point out so that at the highest point they form a V. Make here a short pause before going slowly down and repeating the movement.</p>	{}	{"Anterior deltoid",Trapezius}	{"Biceps brachii"}	13
88	Bench Press Narrow Grip	<p>Lay down on a bench, the bar is directly over your eyes, the knees form a slight angle and the feet are firmly on the ground. Hold the bar with a narrow grip (around 20cm.). Lead the weight slowly down till the arms are parallel to the floor (elbow: right angle), press then the bar up. When bringing the bar down, don't let it down on your nipples as with the regular bench pressing, but somewhat lower.</p>	{https://wger.de/media/exercise-images/88/Narrow-grip-bench-press-1.png,https://wger.de/media/exercise-images/88/Narrow-grip-bench-press-2.png}	{"Triceps brachii"}	{"Anterior deltoid","Pectoralis major"}	8
247	Bendž	<p>Klupa</p>	{}	{}	{}	11
399	Reverse Grip Bench Press	<p>Upper chest focuses exercise that also works triceps</p>	{}	{"Pectoralis major","Triceps brachii"}	{"Anterior deltoid"}	11
142	Rowing, Lying on Bench		{}	{"Latissimus dorsi"}	{}	12
100	Decline Bench Press Barbell	<p>Lay down on a decline bench, the bar should be directly above your eyes, the knees are somewhat angled and the feet are firmly on the floor. Concentrate, breath deeply and grab the bar more than shoulder wide. Bring it slowly down till it briefly touches your chest at the height of your nipples. Push the bar up.</p>	{https://wger.de/media/exercise-images/100/Decline-bench-press-1.png,https://wger.de/media/exercise-images/100/Decline-bench-press-2.png}	{"Pectoralis major"}	{}	11
125	Leg Raises, Lying	<p>Lay down on a bench and hold onto the recliner with your hands to keep you stable. Hold your legs straight and lift them till they make an angle of about 45°. Make a short pause of 1 sec. and go slowly down to the initial position. To increase the intensity you can make a longer pause of 7 sec. every 5th time.</p>	{https://wger.de/media/exercise-images/125/Leg-raises-2.png,https://wger.de/media/exercise-images/125/Leg-raises-1.png}	{"Rectus abdominis"}	{"Serratus anterior"}	10
126	Leg Raises, Standing	<p>Put your forearms on the pads on the leg raise machine, the body is hanging freely. Lift now your legs with a fast movement as high as you can, make a short pause of 1sec at the top, and bring them down again. Make sure that during the exercise your body does not swing, only the legs should move.</p>	{}	{"Rectus abdominis"}	{"Serratus anterior"}	10
218	Smith Machine Close-grip Bench Press	<p>Perform a standard bench press on the smith machine, but have your hands on the bar about shoulder width apart, and keep your elbows close to your body.</p>	{}	{"Triceps brachii"}	{"Pectoralis major"}	8
211	Leverage Machine Chest Press	<p>Be sure to adjust seat height so that the handles are towards the bottom of your pectorals.</p>	{}	{"Pectoralis major"}	{}	11
441	Pull-over  (Extended Arms)	<ul>\n<li>Stand up, take the pull bar and pull down with extended arms.</li>\n<li>Going back to the original position</li>\n</ul>	{}	{"Latissimus dorsi"}	{"Triceps brachii","Pectoralis major"}	12
385	Spinning	<p>The main muscles used in a spinning exercise are the quadriceps.</p>	{}	{"Quadriceps femoris"}	{"Rectus abdominis","Gluteus maximus"}	9
192	Bench Press	<p>Lay down on a bench, the bar should be directly above your eyes, the knees are somewhat angled and the feet are firmly on the floor. Concentrate, breath deeply and grab the bar more than shoulder wide. Bring it slowly down till it briefly touches your chest at the height of your nipples. Push the bar up.</p>\n<p>If you train with a high weight it is advisable to have a <em>spotter</em> that can help you up if you can't lift the weight on your own.</p>\n<p>With the width of the grip you can also control which part of the chest is trained more:</p>\n<ul>\n<li>wide grip: outer chest muscles</li>\n<li>narrow grip: inner chest muscles and triceps</li>\n</ul>	{https://wger.de/media/exercise-images/192/Bench-press-1.png,https://wger.de/media/exercise-images/192/Bench-press-2.png}	{"Pectoralis major"}	{"Biceps brachii"}	11
349	Dumbbell Split Squat	<p>Split Squats with Dumbbells: http://www.bodybuilding.com/exercises/detail/view/name/split-squat-with-dumbbells</p>	{}	{"Quadriceps femoris"}	{}	9
338	Isometric Wipers	<p>Assume push-up position, with hands slightly wider than shoulder width.</p>\n<p>Shift body weight as far as possible to one side, allowing the elbow on that side to flex. </p>\n<p>Reverse the motion, moving completely over to the other side.</p>\n<p>Return to the starting position, and repeat for the desired number of repetitions.</p>	{}	{"Pectoralis major"}	{"Rectus abdominis"}	11
299	Pelvic Tilting Medium Risk	<p>Lay on your back and lift your buttocks off the floor. Feet are flat on the floor. </p>	{}	{}	{"Rectus abdominis"}	12
195	Push Ups	<p>Start with your body streched, your hands are shoulder-wide appart on the ground. Push yourself off the ground till you strech your arms. The back is always straight and as well as the neck (always look to the ground). Lower yourself to the initial position and repeat.</p>	{https://wger.de/media/exercise-images/195/Push-ups-1.png,https://wger.de/media/exercise-images/195/Push-ups-2.png}	{"Triceps brachii"}	{"Anterior deltoid","Pectoralis major","Rectus abdominis"}	8
119	Shoulder Press, Barbell	<p>Sit on a bench, the back rest should be almost vertical. Take a barbell with a shoulder wide grip and bring it up to chest height. Press the weight up, but don't stretch the arms completely. Go slowly down and repeat.</p>	{https://wger.de/media/exercise-images/119/seated-barbell-shoulder-press-large-1.png,https://wger.de/media/exercise-images/119/seated-barbell-shoulder-press-large-2.png}	{"Anterior deltoid"}	{}	13
278	Side Dumbbell Trunk Flexion	<p>AKA dumbbell side bends. Stand in line with the hips with slightly bent knees, maintain the natural curvature of the spine, hand stretched by the body, grip the barbell with one hand. <em> </em>Make slow and controlled torso side flexions till you reach the angle of approximately 45°.</p>	{}	{"Obliquus externus abdominis"}	{"Rectus abdominis"}	12
157	Chin Ups	<p>Pull up</p>	{}	{"Anterior deltoid"}	{"Biceps brachii"}	12
116	Good Mornings		{https://wger.de/media/exercise-images/116/Good-mornings-2.png,https://wger.de/media/exercise-images/116/Good-mornings-1.png}	{"Biceps femoris"}	{}	9
444	Inclined Bench	<p>Simple chest bench machine rotate between chest muscles</p>	{}	{}	{}	11
202	Pendelay Rows	<p>Back excercise with a barbell with a starting position which is in a bent over position with the back paralell to the ground. The barbell is on the ground at chest level.For the movement grab the barbell at shoulder width grip and pull towards your chest without losing the bent over position and without moving anything but your arms</p>	{}	{Trapezius,"Latissimus dorsi"}	{"Triceps brachii","Biceps brachii"}	12
182	Perfect Push Up	<p>Push up with perfect push up</p>	{}	{"Pectoralis major"}	{}	11
170	Splinter Sit-ups	<p>Lie on your back with your legs straight and arms at your sides, keeping your elbows bent at 90 degrees. As you sit up, twist your upper body to the left and bring your left knee toward your right elbow while you swing your left arm back. Lower your body to the starting position, and repeat to your right. That's 1 rep.</p>	{}	{"Obliquus externus abdominis"}	{}	10
305	Z Curls	<p>-Perform a traditional dumbbell biceps curl, pausing at the top of the motion.</p>\n<p>-Twist your hands until your palms are facing away from your shoulders (in reverse curl position).  Basically, twist your right wrist inwards to the left, and vice versa.</p>\n<p>-In a slow, controlled movement, lower the Dbells with your palms facing the ground.  At the bottom of the motion, twist your wrists back into the traditional curl grip (palms facing up, towards shoulder).</p>\n<p>-That is 1 rep</p>\n<p> </p>	{}	{"Biceps brachii",Brachialis}	{}	8
405	Barbell Lunges	<p>Put barbell on the back of your shoulders. Stand upright, then take the first step forward. Step should bring you forward so that your supporting legs knee can touch the floor. Then stand back up and repeat with the other leg.</p>\n<p>Remember to keep good posture.</p>	{}	{"Quadriceps femoris"}	{"Gluteus maximus"}	9
265	Cable External Rotation	<p>Steps:</p>\n<ol>\n<li>Start off placing an extension band around a post or in a secure position where it will not release and is at elbow level.</li>\n<li>Position yourself to the side of the band and with your hand that is opposite of the band, reach out and grab the handle.</li>\n<li>Bring the band to your chest keeping your elbow bent in a 90 degree angle then slowly rotate your arm in a backhand motion so that the band externally rotates out</li>\n<li>Continue out as far as possible so that you feel a stretch in your shoulders, hold for a count and then return back to the starting position.</li>\n<li>Repeat for as many reps and sets as desired.</li>\n</ol>	{}	{"Anterior deltoid"}	{}	13
437	Circuit - Pullups, Pushups, Crunches, Air Squats	<p>Circuit of the 4 exercises</p>\n<ol>\n<li>Pullups x 20 (assisted if needed)</li>\n<li>Pushups x 30</li>\n<li>Crunches x 40</li>\n<li>Air Squats x 50</li>\n</ol>\n<p>Repeat entire circuit 5 times with a 3 min break in between each set</p>	{}	{"Anterior deltoid","Pectoralis major","Rectus abdominis","Quadriceps femoris"}	{"Gluteus maximus"}	9
114	Leg Presses (wide)	<p>Sit on the machine and put your feet on the platform, a bit more than shoulder wide. The feet are turned outwards by a few degrees.</p>\n<p>Lower the weight so much, that the knees form a right angle. Push immediately the platform up again, without any pause. When in the lower position, the knees point a bit outwards and the movement should be always fluid.</p>	{}	{"Quadriceps femoris"}	{"Gluteus maximus"}	9
107	Pull-ups	<p>Grab the pull up bar with a wide grip, the body is hanging freely. Keep your chest out and pull yourself up till your chin reaches the bar or it touches your neck, if you want to pull behind you. Go with a slow and controlled movement down, always keeping the chest out.</p>	{}	{"Latissimus dorsi"}	{"Biceps brachii","Anterior deltoid",Trapezius}	12
150	Shrugs, Barbells	<p>Take a barbell and stand with a straight body, the arms are hanging freely in front of you. Lift from this position the shoulders as high as you can, but don't bend the arms during the movement. On the highest point, make a short pause of 1 or 2 seconds before returning slowly to the initial position.</p>\n<p>When training with a higher weight, make sure that you still do the whole movement!</p>	{https://wger.de/media/exercise-images/150/Barbell-shrugs-1.png,https://wger.de/media/exercise-images/150/Barbell-shrugs-2.png}	{"Anterior deltoid"}	{}	13
151	Shrugs, Dumbbells	<p>Stand with straight body, the hands are hanging freely on the side and hold each a dumbbell. Lift from this position the shoulders as high as you can, but don't bend the arms during the movement. On the highest point, make a short pause of 1 or 2 seconds before returning slowly to the initial position.</p>\n<p>When training with a higher weight, make sure that you still do the whole movement!</p>	{https://wger.de/media/exercise-images/151/Dumbbell-shrugs-2.png,https://wger.de/media/exercise-images/151/Dumbbell-shrugs-1.png}	{"Anterior deltoid"}	{}	13
271	Snach	<p>Stand with your feet at hip width and your shins against the bar. Grasp the bar at double shoulder width and, keeping your lower back flat, drive your heels into the floor to begin lifting the bar. When it's above your knees, explosively extend your hips and shrug your shoulders. Let the momentum carry the weight overhead.</p>	{}	{"Anterior deltoid"}	{}	13
111	Squats	<p>Make sure you have put the barbell at a height where you can comfortably take it out and put it back in. Take it out and make yourself ready:</p>\n<ul>\n<li>The bar is somewhat lower than your shoulders</li>\n<li>The feet are quite apart and point out</li>\n<li>The head is in your neck and looks up</li>\n<li>The chest is out</li>\n</ul>\n<p>Go now slowly down, till your thighs are parallel with the floor, not lower. The knees point outwards, your butt, out. Make a small pause of 1 second and with as much energy as you can, push the weight up. Make a pause of 2 seconds and repeat.</p>	{https://wger.de/media/exercise-images/111/Wide-stance-squat-2.gif,https://wger.de/media/exercise-images/111/Wide-stance-squat-1.gif}	{"Quadriceps femoris"}	{"Gluteus maximus"}	9
258	Upper External Oblique	<p>Exercise for upper external oblique muscles</p>	{}	{"Obliquus externus abdominis"}	{}	11
287	Duck Walks	<p>Grab kettlebell and walk while holding it between legs</p>	{}	{"Biceps brachii",Brachialis,"Triceps brachii"}	{"Rectus abdominis","Obliquus externus abdominis"}	8
233	Front Raises	<p>To execute the exercise, the lifter stands with their feet shoulder width apart and weights or resistance handles held by their side with a pronated (overhand) grip.</p>\n<p>The movement is to bring the arms up in front of the body to eye level and with only a slight bend in the elbow. This isolates the anterior deltoid muscle (front of the shoulder) and uses the anterior deltoid to lift the weight.</p>\n<p>When lifting it is important to keep the body still so the anterior deltoid is fully utilised; if the weight cannot be lifted by standing still then it is too heavy and a lower weight is needed. It is important to keep a slight bend in the elbow when lifting as keeping the elbow locked will add stress to the elbow joint and could cause injury.</p>\n<p>A neutral grip, similar to that used in the hammer curl, can also be used. With this variation the weight is again raised to eye level, but out to a 45 degree angle from the front of the body. This may be beneficial for those with shoulder injuries, particularly those related to the rotator cuff.</p>	{}	{"Anterior deltoid"}	{"Biceps brachii","Serratus anterior"}	13
229	Military Press	<p>The military press is a variation of the overhead press weight training exercise using very strict form and no pre-movement momentum.The military press targets the deltoid muscles in the shoulders as well as the triceps. Additionally, it works the core and legs, which the lifter uses to help stabilize the weight.The lift begins with the lifter standing and the barbell on the anterior deltoids. The lifter then raises the barbell overhead by pressing the palms of the hands against the underside of the barbell.</p>	{}	{"Anterior deltoid"}	{"Triceps brachii","Pectoralis major"}	13
152	Shoulder Press, on Machine		{https://wger.de/media/exercise-images/152/seated-shoulder-press-machine-large-1.png,https://wger.de/media/exercise-images/152/seated-shoulder-press-machine-large-2.png}	{"Anterior deltoid"}	{}	13
227	Arnold Shoulder Press	<p>Very common shoulder exercise.</p>\n<p> </p>\n<p>As shown here: https://www.youtube.com/watch?v=vj2w851ZHRM</p>	{}	{}	{}	13
344	Barbell Triceps Extension	<p>Position barbell overhead with narrow overhand grip.</p>\n<p>Lower forearm behind upper arm with elbows remaining overhead. Extend forearm overhead. Lower and repeat.</p>	{}	{"Triceps brachii"}	{"Anterior deltoid","Pectoralis major"}	8
167	Cable Woodchoppers	<p>Set cable pulley slightly lower than chest height. Keep body facing forward with hips stable.  Grab the pulley handle, fully extend your arms and bring your arms forward and across your body. Hold for 1 second at the end of the movement and slowly return to starting position.</p>	{}	{"Obliquus externus abdominis"}	{}	10
308	Calf Press Using Leg Press Machine	<p>Put  the balls of your feet on an extended leg press pad.  Use your calves to press the weight by flexing your feet/toes into a pointed position, and releasing back into a relaxed position.</p>\n<p>This exercise builds mass and strength in the Gastrocnemius and Soleus muscles as well, if not better, than any calf exercise.</p>	{}	{Gastrocnemius,Soleus}	{}	14
260	Decline Pushups	<p>With your feet raised approximately 30cm on a platform, align your shoulders, elbows and hands, then perform regular pushups. This emphasises the clavicular fibers of the pectoralis major.</p>	{}	{"Pectoralis major"}	{"Triceps brachii","Anterior deltoid"}	11
302	Side to Side Push Ups	<p>-start in push up position</p>\n<p>-lean the body weight to the right side, and complete a push up with the chest over the right hand</p>\n<p>-come back to the centered position</p>\n<p>-on rep 2, lean to the left side</p>	{}	{"Anterior deltoid","Pectoralis major","Obliquus externus abdominis","Triceps brachii"}	{}	11
432	High Knees	<p>-Start with legs at a comfortable standing width</p>\n<p>-Run in place, bringing knees to or above waist level</p>	{}	{Gastrocnemius,"Quadriceps femoris",Soleus}	{"Rectus abdominis"}	9
445	Inclined Bench	<p>Simple chest bench machine rotate between chest muscles</p>	{}	{}	{}	11
188	Lat Pull Down (Leaning Back)	<p>Lean Back, Pull into chest</p>	{}	{"Latissimus dorsi"}	{}	12
270	Pause Bench	<p>Lower the bar to your chest and pause (but do not rest) there for 2 seconds. Press back up. use the same weight you would on bench press, but perform only single reps. Total the number of reps you did in one set of bench press (if you did 3 sets of 8 do 8 sinlge pause bench reps.</p>	{}	{"Pectoralis major"}	{"Triceps brachii"}	11
443	Plank Walk Up	<p>Hand Plank Position then walk up til butt is the air.</p>	{}	{}	{}	10
246	Propadanje	<p>Grudi</p>	{}	{}	{}	11
140	Pull Ups on Machine		{}	{"Latissimus dorsi"}	{"Biceps brachii","Anterior deltoid",Trapezius}	12
398	Run - Interval Training 	<p>Run and do some interval trainings such as hill repat, fartlek,..</p>	{}	{}	{}	9
209	Stiff-legged Deadlifts	<ul>\n<li>Keep legs straight</li>\n<li>Keep back straight</li>\n</ul>	{}	{"Biceps femoris"}	{"Gluteus maximus"}	9
215	Straight-arm Pull Down (rope Attachment)	<p>Use the rope attachment on a high pulley. Grasp the two ends of the rope with your arms straight out in front of you. Pull your hands down towards your hips, while keeping your arms straight, then raise them back up to the starting position.</p>	{}	{"Latissimus dorsi"}	{"Triceps brachii"}	12
179	Trazioni Alla Sbarra Presa Inversa	<p>Trazioni alla sbarra presa inversa</p>	{}	{"Latissimus dorsi"}	{}	12
204	Wide-grip Pulldown	<p>Lat pulldowns with a wide grip on the bar.</p>	{}	{"Latissimus dorsi"}	{}	12
342	Braced Squat	<p>Stand with feet slightly wider than shoulder-width apart, while standing as tall as you can.</p>\n<p>Grab a weight plate and hold it out in front of your body with arms straight out. Keep your core tight and stand with a natural arch in your back.</p>\n<p>Now, push hips back and bend knees down into a squat as far as you can. Hold for a few moments and bring yourself back up to the starting position.</p>	{}	{"Quadriceps femoris"}	{"Gluteus maximus"}	9
274	Dumbbell Triceps Extension	<p>Position one dumbbell over head with both hands under inner plate (heart shaped grip).</p>\n<p>With elbows over head, lower forearm behind upper arm by flexing elbows. Flex wrists at bottom to avoid hitting dumbbell on back of neck. Raise dumbbell over head by extending elbows while hyperextending wrists. Return and repeat.</p>	{}	{"Triceps brachii"}	{"Anterior deltoid","Pectoralis major"}	8
146	Fly With Dumbbells, Decline Bench	<p>The exercise is the same as with a regular bench:</p>\n<p>Take two dumbbells and lay on a bench, make sure the feet are firmly on the ground and your back is not arched, but has good contact with the bench. The arms are stretched in front of you, about shoulder wide. Bend now the arms a bit and let them down with a half-circle movement to the side. Without changing the angle of the elbow bring them in a fluid movement back up.</p>	{}	{"Pectoralis major"}	{}	11
423	Jogging	<p>Get your shoes on, go outside and start running at a moderate pace.</p>	{}	{}	{}	9
155	Shoulder Press, on Multi Press	<p>The exercise is basically the same as with a free barbell:</p>\n<p>Sit on a bench, the back rest should be almost vertical. Take a bar with a shoulder wide grip and bring it down to chest height. Press the weight up, but don't stretch the arms completely. Go slowly down and repeat.</p>	{}	{"Anterior deltoid"}	{}	13
438	Limbert	<p>Lay down on a bench, the bar should be directly above your eyes, the knees are somewhat angled and the feet are firmly on the floor. Concentrate, breath deeply and grab the bar more than shoulder wide. Bring it slowly down till it briefly touches your chest at the height of your nipples. Push the bar up.</p>\n<p>If you train with a high weight it is advisable to have a <em>spotter</em> that can help you up if you can't lift the weight on your own.</p>\n<p>With the width of the grip you can also control which part of the chest is trained more:</p>\n<ul>\n<li>wide grip: outer chest muscles</li>\n<li>narrow grip: inner chest muscles and triceps</li>\n<li>Don't stretch your arms completly</li>\n</ul>	{}	{}	{}	11
279	Tricep Dumbbell Kickback	<ol>\n<li>Start with a dumbbell in each hand and your palms facing your torso. Keep your back straight with a slight bend in the knees and bend forward at the waist. Your torso should be almost parallel to the floor. Make sure to keep your head up. Your upper arms should be close to your torso and parallel to the floor. Your forearms should be pointed towards the floor as you hold the weights. There should be a 90-degree angle formed between your forearm and upper arm. This is your starting position.</li>\n<li>Now, while keeping your upper arms stationary, exhale and use your triceps to lift the weights until the arm is fully extended. Focus on moving the forearm.</li>\n<li>After a brief pause at the top contraction, inhale and slowly lower the dumbbells back down to the starting position.</li>\n<li>Repeat the movement for the prescribed amount of repetitions.</li>\n</ol>\n<p><strong>Variations:</strong> This exercise can be executed also one arm at a time much like the one arm rows are performed.</p>\n<p>Also, if you like the one arm variety, you can use a low pulley handle instead of a dumbbell for better peak contraction. In this case, the palms should be facing up (supinated grip) as opposed to the torso (neutral grip).</p>	{}	{"Triceps brachii"}	{}	8
203	Wall Pushup	<p>Pushup against a wall</p>	{}	{"Anterior deltoid","Pectoralis major","Triceps brachii"}	{"Serratus anterior","Rectus abdominis","Gluteus maximus",Trapezius}	8
110	Bent Over Rowing Reverse	<p>The same as <em>regular</em> rowing, but holding a reversed grip (your palms pointing forwards):</p>\n<p>Grab the barbell with a wide grIp (slightly more than shoulder wide) and lean forward. Your upper body is not quite parallel to the floor, but forms a slight angle. The chest's out during the whole exercise.</p>\n<p>Pull now the barbell with a fast movement towards your belly button, not further up. Go slowly down to the initial position. Don't swing with your body and keep your arms next to your body.</p>	{https://wger.de/media/exercise-images/110/Reverse-grip-bent-over-rows-1.png,https://wger.de/media/exercise-images/110/Reverse-grip-bent-over-rows-2.png}	{"Latissimus dorsi"}	{"Biceps brachii","Anterior deltoid"}	12
248	Razboj	<p>Razboj</p>	{}	{}	{}	11
94	Crunches on Machine	<p>The procedure is very similar as for regular crunches, only with the additional weight of the machine. Sit on the machine, put both feet firmly on the ground. Grab the to the weights, cables, etc. and do a rolling motion forwards (the spine should ideally lose touch vertebra by vertebra). Slowly return to the starting position. </p>	{}	{"Rectus abdominis"}	{}	10
108	Rowing, Seated		{}	{"Latissimus dorsi"}	{}	12
357	Run/Walk	<p>Run and Walk</p>\n<p>------------------------------------------------------------</p>	{}	{}	{}	9
275	Dumbbell Concentration Curl	<p>Sit on bench. Grasp dumbbell between feet. Place back of upper arm to inner thigh. Lean into leg to raise elbow slightly.</p>	{}	{Brachialis}	{"Biceps brachii"}	8
414	Extenseurs - Face	<p>En face</p>\n<ol>\n<li>Tirer</li>\n<li>relacher doucement</li>\n</ol>	{}	{}	{}	11
191	Front Squats	<p>Squats</p>	{https://wger.de/media/exercise-images/191/Front-squat-1-857x1024.png,https://wger.de/media/exercise-images/191/Front-squat-2-857x1024.png}	{"Gluteus maximus"}	{"Rectus abdominis"}	9
149	Lateral Raises on Cable, One Armed	<p>.</p>	{}	{"Anterior deltoid"}	{}	13
177	Leg Extension	<p>Seated Leg Extension Machine</p>	{https://wger.de/media/exercise-images/177/Seated-leg-curl-1.png,https://wger.de/media/exercise-images/177/Seated-leg-curl-2.png}	{"Quadriceps femoris"}	{}	9
281	L Hold	<p>Hold the L position for as long as possible</p>	{}	{}	{}	10
312	Lying Rotator Cuff Exercise	<p>This is an excercise for problems with the levator muscles. Primary  Infraspinatus, secondary Teres Minor.</p>\n<p>Lying on side. Keep elbow on waist and in 90 dgr angle. Rotate towards stomach. Add weight as fit.</p>	{}	{}	{}	13
440	Pullover With Dumbbell	<p>Bajar la mancuerna por detras de la cabeza</p>\n<p>Volver a la posición inicial</p>	{}	{"Pectoralis major"}	{"Triceps brachii","Serratus anterior"}	11
345	2 Handed Kettlebell Swing	<p>Two Handed Russian Style Kettlebell swing</p>	{}	{}	{}	10
407	Barbell Hack Squats	<p>Perform leg squats with barbell behind your legs</p>	{}	{"Quadriceps femoris"}	{"Gluteus maximus"}	9
97	Benchpress Dumbbells	<p>The movement is very similar to benchpressing with a barbell, however, the weight is brought down to the chest at a lower point.</p>\n<p>Hold two dumbbells and lay down on a bench. Hold the weights next to the chest, at the height of your nipples and press them up till the arms are stretched. Let the weight slowly and controlled down.</p>	{https://wger.de/media/exercise-images/97/Dumbbell-bench-press-1.png,https://wger.de/media/exercise-images/97/Dumbbell-bench-press-2.png}	{"Pectoralis major"}	{"Triceps brachii","Anterior deltoid"}	11
268	Bent High Pulls	<p>Bend over slightly while holding two dumbbells.  Pull the dumbbells up to your chest, keeping your elbows as high as you can.</p>	{}	{Trapezius}	{}	13
429	Prone Scapular Retraction - Arms at Side	<p>Lying on stomach with head on towel.</p>\n<p>Stretch arms straight out to your sides.</p>\n<p>Slowly lift your arms, pulling your shoulderblades together, hold for 3 seconds.</p>\n<p> </p>	{}	{Trapezius}	{}	12
330	Superman	<p>Lay flat on your stomach with your arms extended in front of you on the ground as your legs are lying flat. Lift both your arms and legs at the same time, as if you were flying, and contract the lower back. Make sure that you are breathing and, depending on your fitness level, hold the movement for at least two to five seconds per repetition.</p>	{}	{"Gluteus maximus","Latissimus dorsi"}	{}	12
410	Arch Hold	<p>Opposite of hollow hold. Lie on stomach with arms and legs extended. See https://www.youtube.com/watch?v=44ScXWFaVBs&amp;feature=youtu.be&amp;t=7m51s</p>	{}	{}	{}	10
289	Axe Hold	<p>Grab dumbbells and extend arms to side and hold as long as you can</p>	{}	{"Anterior deltoid",Trapezius}	{Trapezius}	8
388	Bear Walk	<p>-Rest your weight on your palms and the balls of your feet, not dissimilar to normal pushup position</p>\n<p>-Move by stepping with your R palm and L foot, then your L palm and R foot.  Basically, walk like a lumbering bear.</p>\n<p>-Move as fast as you can.  Measure your reps/sets in either distance (i.e. 40 yards) or time (i.e. 45 seconds)</p>\n<p>-Works your Pecs, Deltoids, Triceps, Traps, Lats, Abs and Lower Back, Hip Flexors, Quads, Glutes and Calves</p>	{}	{}	{}	11
412	Bent Over Barbell Row	<ol>\n<li>Holding a barbell with a pronated grip (palms facing down), bend your knees slightly and bring your torso forward, by bending at the waist, while keeping the back straight until it is almost parallel to the floor. Tip: Make sure that you keep the head up. The barbell should hang directly in front of you as your arms hang perpendicular to the floor and your torso. This is your starting position.</li>\n<li>Now, while keeping the torso stationary, breathe out and lift the barbell to you. Keep the elbows close to the body and only use the forearms to hold the weight. At the top contracted position, squeeze the back muscles and hold for a brief pause.</li>\n<li>Then inhale and slowly lower the barbell back to the starting position.</li>\n<li>Repeat for the recommended amount of repetitions.</li>\n</ol>	{}	{}	{}	12
428	Cable Pushdown (with Rope Attachment)	\nFace high pulley and grasp rope attachment with clinched hands side by side (palms in). Position elbows to side.\n\n\nExtend arms down. Turn palms down at bottom. Return until forearm is close to upper arm and hands are in original position. Repeat.\n	{}	{"Triceps brachii"}	{}	8
290	Car Push	<p>Place car in neutral (with partner to apply breaks if necessary) and drive with legs to push car</p>	{}	{Gastrocnemius,Soleus}	{"Quadriceps femoris"}	14
194	Cross-Bench Dumbbell Pullovers	<p>Grasp a moderately weighted dumbbell so your palms are flat against the underside of the top plates and your thumbs are around the bar. Lie on your back across a flat bench so only your upper back and shoulders are in contact with the bench. Your feet should be set about shoulder-width apart and your head should hang slightly downward. With the dumbbell supported at arm's length directly about your chest, bend your arms about 15 degrees and keep them bent throughout the movement. Slowly lower the dumbbell backward and downward in a semicircle arc to as low a position as is comfortably possible. Raise it slowly back along the same arc to the starting point, and repeat for the required number of repetitions.</p>	{}	{"Serratus anterior","Pectoralis major","Latissimus dorsi"}	{}	11
394	Facepull	<p>Attach a rope to a pulley station set at about chest level.</p>\n<p>Step back so you're supporting the weight with arms completely outstretched and assume a staggered (one foot forward) stance. Bend the knees slightly for a stable base.</p>\n<p>Retract the scapulae (squeeze your partner's finger with your shoulder blades) and pull the center of the rope slightly up towards the face. A good cue is to think about pulling the ends of the rope apart, not just pulling back.</p>\n<p>As you near your face, externally rotate so your knuckles are facing the ceiling.</p>\n<p>Hold for one second at the top position and slowly lower.</p>	{}	{Trapezius}	{}	13
189	Power Clean	<p>Olympic weight lifting</p>	{}	{"Pectoralis major"}	{"Quadriceps femoris"}	13
436	10 Min Abs	<p>1 Minute for each exercise</p>\n<ol>\n<li>Hold feet 6 inches off ground</li>\n<li>Crunches</li>\n<li>Side Crunches (L)</li>\n<li>Side Crunches (R)</li>\n<li>Heel Touches</li>\n<li>Plank Crunch</li>\n<li>Scissor Kicks</li>\n<li>Swim Kicks</li>\n<li>V Crunches</li>\n<li>Hold feet 6 in off ground</li>\n</ol>\n<p>Exercises can be substituted to vary workout</p>	{}	{}	{}	10
421	Bent-over Lateral Raises	<p>Sit on bench while holding weights. Bend forward as far as possible, with arms slightly bent at the elbow. Perform a lateral raise while maintaining the bend in your elbow.</p>	{}	{}	{}	13
273	Biking	<p>Biking</p>	{}	{}	{}	9
272	Biking	<p>Biking</p>	{}	{}	{}	9
316	Body Squats	<p>6 Second Reps Max 15 Reps</p>\n<p>6 Second Reps Max 15 Reps</p>	{}	{}	{}	9
354	Burpees	<p>Jump, lay down on your chest, do a pushup then jump, repeat</p>	{}	{}	{}	11
267	Depth Jumps	<p>Depth Jumps</p>\n<p> </p>	{}	{}	{}	9
408	Glute Bridge	<p>Lie on you back with your hips and knees flexed, feet on the ground. From this position, raise your butt off of the ground to a height where your body makes a straight line from your knees to your shoulders. To make the exercise more intense, you can add weight by letting a barbell rest on your hips as you complete the motion, or you can put your feet on a slightly higher surface such as a step or a bench.</p>	{}	{"Gluteus maximus"}	{"Biceps femoris"}	9
168	Incline Pushups	<p>Regular push with a 30 degree incline.</p>	{}	{"Pectoralis major"}	{"Biceps femoris"}	11
389	Low Box Squat - Wide Stance	<p>Unrack the bar and set your stance wide, beyond your hips.  Push your hips back and sit down to a box that takes you below parallel.  Sit completely down, do not touch and go.  Then explosively stand up.  Stay tight in your upper back and torso throughout the movement.</p>	{}	{"Gluteus maximus","Quadriceps femoris"}	{}	9
219	Super Squat	<p>Yep</p>	{}	{"Rectus abdominis","Quadriceps femoris"}	{"Biceps femoris"}	12
396	Thruster	<ol>\n<li>Start by doing a front squat</li>\n<li>At the top position, push the bar above your head (similar to a press)</li>\n<li>Lower the bar to the shoulders</li>\n</ol>	{}	{"Anterior deltoid","Quadriceps femoris"}	{"Triceps brachii","Gluteus maximus",Trapezius,"Biceps femoris"}	9
212	Underhand Lat Pull Down	<p>Grip the pull-down bar with your palms facing you and your hands closer than shoulder-width apart. Lean back slightly and keep your back straight. Pull the bar down towards your chest, pulling your shoulders back slightly at the end of the motion.</p>	{}	{"Latissimus dorsi"}	{"Biceps brachii"}	12
249	Kettlebell Swings	<p>Hold the kettlebell securely in both hands. Keep your back flat throughout the move, avoiding any rounding of the spine.Keeping your knees "soft", hinge your hips backwards, letting the kettlebell swing between your knees.</p>\n<p>You want to bend from the hips as far as you can <em>without letting your back round forwards</em>. Then, snap your hips forwards quickly and standing up straight, locking your body in an upright posture.</p>\n<p>The speed you do this will cause your arms and the kettlebell to swing up in front of you. Don't try to <em>lift</em> the kettlebell with your arms. The snapping forwards of your hips will cause the kettlebell to swing forwards through momentum. Depending on the weight of the kettlebell and the speed of your hip movement, your arms will swing up to about shoulder height. At the top of this swing, let your hips hinge backwards again as the kettlebell swings back down to between your legs and the start of the next repetition.</p>	{}	{"Gluteus maximus"}	{"Biceps femoris"}	9
205	Single-arm Preacher Curl	<p>Sit on the preacher curl bench and perform a bicep curl with a dumbbell in one hand. Your other hand can be at rest, or beneath your curling arm's elbow.</p>	{}	{"Biceps brachii"}	{}	8
343	Barbell Ab Rollout	<p>Place a barbell on the floor at your feet.</p>\n<p>Bending at the waist, grip the barbell with a shoulder with overhand grip.</p>\n<p>With a slow controlled motion, roll the bar out so that your back is straight.</p>\n<p>Roll back up raising your hips and butt as you return to the starting position.</p>	{}	{"Rectus abdominis","Obliquus externus abdominis"}	{"Anterior deltoid","Latissimus dorsi"}	10
341	Body-Ups	<ol>\n<li>Assume a plank position on the ground. You should be supporting your bodyweight on your toes and forearms, keeping your torso straight. Your forearms should be shoulder-width apart. This will be your starting position.</li>\n<li>Pressing your palms firmly into the ground, extend through the elbows to raise your body from the ground. Keep your torso rigid as you perform the movement.</li>\n<li>Slowly lower your forearms back to the ground by allowing the elbows to flex.</li>\n<li>Repeat as needed.</li>\n</ol>	{}	{"Triceps brachii"}	{}	8
346	Bulgarian Split Squat	<p>Rest back foot on an elevated surface with sole pointing up. keep your weight over your front leg as you lower yourself</p>	{}	{}	{}	9
207	Cable Cross-over	<p>Begin with cables at about shoulder height, one in each hand. Take a step forward so that one foot is in front of the other, for stability, and so that there is tension on the cables. Bring hands together in front of you. Try to make your hands overlap (so that the cables cross) a few inches.</p>	{}	{"Pectoralis major"}	{}	11
291	Hercules Pillars	<p>Grab two cables stand in the middle so both have tension and hold</p>	{}	{"Biceps brachii",Brachialis,"Triceps brachii"}	{"Anterior deltoid"}	8
254	Low Row Machine	<p>Specific product for building strength in the trunk and latissimus dorsi muscles. The exercise involves pulling the two independent levers towards the chest, keeping the arms out in front and the elbows low, parallel to the shoulders. Resistance is provided by a weight stack which enables the workload to be adjusted to suit each type of user.</p>\n<p>- http://www.technogym.com/gb/products/strength-training-equipment/core-exercise-equipment/selection/low-row/427</p>\n<p> </p>\n<p>Muscels:</p>\n<ul>\n<li>Rhomboid</li>\n</ul>	{}	{}	{"Biceps brachii","Latissimus dorsi"}	12
197	Overhand Cable Curl	<p>Hands at shoulder height, curl arms in toward head, then back out.</p>	{}	{"Biceps brachii"}	{}	10
360	Ring Dips	<p>Dips peformed on gymnastic rings.</p>	{}	{"Triceps brachii"}	{}	8
263	Roman Chair	<p>Crunches on roman chair</p>	{}	{}	{}	10
386	Seated Triceps Press	<p>Sit down on a back (better with back support). Take a dumbbell firmly with both hands and hold it with extended arms over your head. With your palms facing upward and holding the weight of the dumbbell, slowly lower the weight behind your head.</p>\n<p> </p>	{}	{"Triceps brachii"}	{}	8
176	Side Crunch	<p>Hold weight in one hand. Bend side ways to the knee. Pull upo to upright position using your obliquus.</p>	{https://wger.de/media/exercise-images/176/Cross-body-crunch-1.png,https://wger.de/media/exercise-images/176/Cross-body-crunch-2.png}	{"Obliquus externus abdominis"}	{"Rectus abdominis"}	10
328	Speed Deadlift	<p>Deadlift with short (&lt;1min) rest between sets.</p>	{}	{}	{}	9
439	Test	<p>Oh yes i forgot about this thanks!</p>	{}	{"Biceps brachii"}	{"Biceps brachii"}	10
310	Trunk Rotation With Cable 	<p>Seated trunk rotation with cable </p>	{}	{"Obliquus externus abdominis"}	{"Latissimus dorsi"}	10
324	Dumbbell Side Bends	<p>1. Stand straight with shoulders and feet wide apart and hold a dumbbell in your left hand.</p>\n<p>2. Starting position: Place your right hand on your waist.</p>\n<p>3. Now, keep your head and back straight and bend only from your waist to your right.</p>\n<p>4. Inhale, and bend as much as you can and hold for a count of two.</p>\n<p>5. Final position: Get back to the start position, exhale as you do so.</p>\n<p> </p>\n<p>6. Now perform the similar steps bending to your left.</p>\n<p> </p>\n<p>Reference : http://workouttrends.com/how-to-do-dumbbell-side-bends</p>	{}	{}	{}	10
163	Incline Bench Press	<p>To do slowly, tempo is 4010</p>	{https://wger.de/media/exercise-images/163/Incline-bench-press-1.png,https://wger.de/media/exercise-images/163/Incline-bench-press-2.png}	{"Pectoralis major"}	{"Triceps brachii"}	11
206	Incline Dumbbell Flye	<p>Use inclined bench. Hold dumbbells straight out to your sides, elbows slightly bent. Bring arms together above you, keeping angle of elbows fixed.</p>	{}	{"Pectoralis major"}	{}	11
340	Incline Dumbbell Row	<ol>\n<li>Using a neutral grip, lean into an incline bench.</li>\n<li>Take a dumbbell in each hand with a neutral grip, beginning with the arms straight. This will be your starting position.</li>\n<li>Retract the shoulder blades and flex the elbows to row the dumbbells to your side.</li>\n<li>Pause at the top of the motion, and then return to the starting position.</li>\n</ol>	{}	{}	{"Latissimus dorsi"}	12
392	Pompes	<p>Mettez vous sur le ventre, soulevez vous à la force de vos bras...</p>	{}	{}	{}	8
409	Reverse Plank	<p>Plank with stomach towards ceiling</p>	{}	{}	{}	10
123	Shoulder Press, Dumbbells	<p>Sit on a bench, the back rest should be almost vertical. Take two dumbbells and bring them up to shoulder height, the palms and the elbows point during the whole exercise to the front. Press the weights up, at the highest point they come very near but don't touch. Go slowly down and repeat.</p>	{https://wger.de/media/exercise-images/123/dumbbell-shoulder-press-large-1.png,https://wger.de/media/exercise-images/123/dumbbell-shoulder-press-large-2.png}	{"Anterior deltoid"}	{}	13
379	Walking	Walking, distance and time. Should allow a range of inputs (running, etc)	{}	{}	{}	9
288	Yolk Walks	<p>Grab barbell and place on shoulders then walk</p>	{}	{"Anterior deltoid",Trapezius}	{"Rectus abdominis","Obliquus externus abdominis"}	13
109	Bent Over Rowing	<p>Grab the barbell with a wide grip (slightly more than shoulder wide) and lean forward. Your upper body is not quite parallel to the floor, but forms a slight angle. The chest's out during the whole exercise.</p>\n<p>Pull now the barbell with a fast movement towards your belly button, not further up. Go slowly down to the initial position. Don't swing with your body and keep your arms next to your body.</p>	{https://wger.de/media/exercise-images/109/Barbell-rear-delt-row-1.png,https://wger.de/media/exercise-images/109/Barbell-rear-delt-row-2.png}	{"Latissimus dorsi"}	{"Biceps brachii","Anterior deltoid"}	12
113	Dumbbell Lunges Walking	<p>Take two dumbbells in your hands, stand straight, feet about shoulder wide. Take one long step so that the front knee is approximately forming a right angle. The back leg is streched, the knee is low but doesn't touch the ground. "Complete" the step by standing up and repeat the movement with the other leg.</p>	{https://wger.de/media/exercise-images/113/Walking-lunges-1.png,https://wger.de/media/exercise-images/113/Walking-lunges-2.png,https://wger.de/media/exercise-images/113/Walking-lunges-3.png,https://wger.de/media/exercise-images/113/Walking-lunges-4.png}	{"Quadriceps femoris"}	{"Gluteus maximus"}	9
118	Leg Curls (standing)		{https://wger.de/media/exercise-images/118/standing-leg-curls-large-1.png,https://wger.de/media/exercise-images/118/standing-leg-curls-large-2.png}	{"Biceps femoris"}	{}	9
214	Leverage Machine Iso Row	<p>Adjust seat height so that the handles are at the bottom of your pectorals or just below.</p>	{}	{"Latissimus dorsi"}	{}	12
74	Biceps Curls With Barbell	<p>Hold the Barbell shoulder-wide, the back is straight, the shoulders slightly back, the arms are streched. Bend the arms, bringing the weight up, with a fast movement. Without pausing, let down the bar with a slow and controlled movement.</p>\n<p>Don't allow your body to swing during the exercise, all work is done by the biceps, which are the only mucles that should move (pay attention to the elbows).</p>	{https://wger.de/media/exercise-images/74/Bicep-curls-1.png,https://wger.de/media/exercise-images/74/Bicep-curls-2.png}	{"Biceps brachii"}	{Brachialis}	8
217	Close-grip Bench Press	<p>Perform a typical bench press, but hold the bar with your hands approximately shoulder-width apart and keep your elbows close to your body.</p>	{}	{"Triceps brachii"}	{"Pectoralis major"}	8
323	Decline Press Sit-Up	<ol>\n<li>Lie down on a bench with a barbell resting on your chest. Position your legs so they are secure on the extension of the abdominal bench.</li>\n<li>While inhaling, tighten your abdominals and glutes. Simultaneously curl your torso as you do when performing a sit-up and press the barbell to an overhead position while exhaling. </li>\n<li>Lower your upper body back down to the starting position while bringing the barbell back down to your torso. Remember to breathe in while lowering the body.</li>\n</ol>\n<p>Caution: It is best to have a spotter while performing this exercise so that it is easier to get the barbell and also get rid of it. Also, always start with an empty bar and do not use jerking motions at any time.</p>\n<p> </p>\n<p>Reference: http://www.bodybuilding.com/exercises/detail/view/name/press-sit-up</p>	{}	{"Anterior deltoid"}	{}	10
106	Rowing, T-bar	<p>The execution of this exercise is very similar to the regular bent over rowing, only that the bar is fixed here.</p>\n<p>Grab the barbell with a wide grip (slightly more than shoulder wide) and lean forward. Your upper body is not quite parallel to the floor, but forms a slight angle. The chest's out during the whole exercise. Pull now the barbell with a fast movement towards your belly button, not further up. Go slowly down to the initial position. Don't swing with your body and keep your arms next to your body.</p>	{https://wger.de/media/exercise-images/106/T-bar-row-1.png,https://wger.de/media/exercise-images/106/T-bar-row-2.png}	{"Latissimus dorsi"}	{"Biceps brachii","Anterior deltoid",Brachialis}	12
166	Hanging Leg Raises	<p>Hanging from bar or straps, bring legs up with knees extended or flexed</p>	{}	{"Rectus abdominis"}	{}	10
298	Dumbbell Incline Curl	<p>With elbows back to sides, raise one dumbbell and rotate forearm until forearm is vertical and palm faces shoulder. Lower to original position and repeat with opposite arm. Continue to alternate between sides.</p>	{}	{"Biceps brachii"}	{Brachialis}	8
144	Long-Pulley, Narrow	<p>The exercise is the same as the regular long pulley, but with a narrow grip:</p>\n<p>Sit down, put your feet on the supporting points and grab the bar with a wide grip. Pull the weight with a rapid movement towards your belly button, not upper. Keep your arms and elbows during the movement close to your body. Your shoulders are pulled together. Let the weight slowly down till your arms are completely stretched.</p>	{}	{"Latissimus dorsi"}	{"Biceps brachii",Brachialis}	12
362	Bentover Dumbbell Rows	<p>With dumbbells in hand, bend at the hip until hands hang just below the knees (similar to straight-legged-deadlift starting position). Keep upper body angle constant while contracting your lats to pull you ellbows back pinching the shoulder blades at the top. Try not to stand up with every rep, check hands go below knees on every rep.</p>	{}	{"Latissimus dorsi"}	{"Biceps brachii","Biceps femoris",Brachialis}	12
81	Biceps Curls With Dumbbell	<p>Hold two barbells, the arms are streched, the hands are on your side, the palms face inwards. Bend the arms and bring the weight with a fast movement up. At the same time, rotate your arms by 90 degrees at the very beginning of the movement. At the highest point, rotate a little the weights further outwards. Without a pause, bring them down, slowly.</p>\n<p>Don't allow your body to swing during the exercise, all work is done by the biceps, which are the only mucles that should move (pay attention to the elbows).</p>	{https://wger.de/media/exercise-images/81/Biceps-curl-1.png,https://wger.de/media/exercise-images/81/Biceps-curl-2.png}	{"Biceps brachii"}	{Brachialis}	8
80	Biceps Curls With SZ-bar	<p>Hold the SZ-bar shoulder-wide, the back is straight, the shoulders slightly back, the arms are streched. Bend the arms, bringing the weight up, with a fast movement. Without pausing, let down the bar with a slow and controlled movement.</p>\n<p>Don't allow your body to swing during the exercise, all work is done by the biceps, which are the only mucles that should move (pay attention to the elbows).</p>	{}	{"Biceps brachii"}	{Brachialis}	8
300	Dumbbell Goblet Squat	<p>Grasp dumbbell with both hands at the sides of the upper plates. Hold dumbbell in front of chest, close to torso. Place feet about shoulderwide apart, keep knees slightly bent.</p>\n<p>Squat down until thighs are parallel to floor. Keep back straight, bend and move hips backward to keep knees above feet. Return, keep knees slightly flexed. Repeat.</p>\n<p>Keep bodyweight on heels and look ahead or slightly above to keep back straight.</p>	{}	{"Quadriceps femoris"}	{}	9
286	Farmers Walks	<p>Grab dumbbells and walk</p>\n<p> </p>	{}	{"Biceps brachii","Biceps femoris",Brachialis}	{Trapezius}	8
262	Glute	<p>Glute machine</p>	{}	{}	{}	12
86	Hammercurls	<p>Hold two dumbbells and sit on a bench with a straight back, the shoulders are slightly rolled backwards. Your pals point to your body. Bend the arms and bring the weight up with a fast movement. Don't rotate your hands, as with the curls. Without any pause bring the dumbbell down with a slow, controlled movement.</p>\n<p>Don't swing your body during the exercise, the biceps should do all the work here. The elbows are at your side and don't move.</p>	{https://wger.de/media/exercise-images/86/Bicep-hammer-curl-1.png,https://wger.de/media/exercise-images/86/Bicep-hammer-curl-2.png}	{"Biceps brachii"}	{}	8
355	Overhead Squat	<p>The barbell is held overhead in a wide-arm snatch grip; however, it is also possible to use a closer grip if balance allows.</p>	{}	{}	{}	9
190	Push Press	<p>olympic weight lifting</p>	{}	{Trapezius}	{"Gluteus maximus"}	13
347	Deadhang	<p>Deadhang performed on an edge either with or without added weight (adujst edge or weight to adjust difficulty)</p>	{}	{}	{}	8
237	Rear Delt Raises	<p>Seated on a bench bWith the dumbbells on the floor bend over at 45 Degrees and then slowly raise each dumbbell to shoulder height and hold for a couple seconds before lowering to the starting position. </p>\n<p> </p>	{}	{}	{}	13
446	Roman Chair Crunch	<p>Use Hyperextension chair.  Sit on chair, arms crossed on over your chest. then situp slowly and back</p>	{}	{"Obliquus externus abdominis"}	{}	10
82	Dips	<p>Hold onto the bars at a narrow place (if they are not parallel) and press yourself up, but don't stretch the arms completely, so the muscles stay during the whole exercise under tension. Now bend the arms and go down as much as you can, keeping the elbows always pointing back, At this point, you can make a short pause before repeating the movement.</p>	{https://wger.de/media/exercise-images/82/Tricep-dips-2-1.png,https://wger.de/media/exercise-images/82/Tricep-dips-2-2.png}	{"Triceps brachii"}	{"Pectoralis major","Rectus abdominis"}	8
326	Full Sit Outs	<p>(A) Get in high plank position on your hands and toes.(B) Shift your weight to your left hand as you turn your body to the right; bend your right leg behind you and extend your right arm up. Return to the center and repeat on the opposite side. Continue, alternating sides.<strong>Make it easier:</strong> Don’t raise your arm after you bend your leg behind you.<strong>Make it harder:</strong> Balance with your arm and leg extended for two counts.</p>	{}	{"Rectus abdominis","Gluteus maximus","Obliquus externus abdominis"}	{}	10
115	Leg Presses (narrow)	<p>The exercise is very similar to the wide leg press:</p>\n<p>Sit on the machine and put your feet on the platform so far apart  that you could just put another foot in between them. The feet are parallel and point up.</p>\n<p>Lower the weight so much, that the knees form a right angle. Push immediately the platform up again, without any pause. When in the lower position, the knees point a bit outwards and the movement should be always fluid.</p>	{}	{"Quadriceps femoris"}	{"Gluteus maximus"}	9
256	Military Press	<p>On an SZ-bar grip your hands on the outside of each bend and stand with your arms straight down, palms facing your legs. Pull the bar (bending your arms at the elbow) to your chest, and the push the bar above your head (arms as straight as possible). Return the bar to your chest by dropping your arms at the elbows. Return the bar to it's origional position (stand with your arms straight down, palms facing your legs.)</p>	{}	{}	{}	8
103	Sitting Calf Raises	<p>Sit on a bench for calf raises and check that the feet are half free and that you can completely stretch the calf muscles down. Pull your calves up, going as far (up) as you can. Make at the highest point a short pause of 1 or 2 seconds and go down.</p>	{}	{Soleus}	{Gastrocnemius}	14
293	Stationary Bike	<p>Ride a Stationary Bike with various tensions.</p>	{}	{}	{}	9
89	Triceps Extensions on Cable	<p>Grab the cable, stand with your feet shoulder wide, keep your back straight and lean forward a little. Push the bar down, making sure the elbows don't move during the exercise. Rotate your hands outwards at the very end and go back to the initial position without pause.</p>	{}	{"Triceps brachii"}	{}	8
359	Wall Handstand	<p>Handstand against a wall for support (chest facing wall).</p>	{}	{}	{}	13
320	Weighted Step	<p>Box step-ups w/ barbell, 45's on each side</p>	{}	{}	{}	9
159	Wyciskanie Skos	<p>wyciskanie skośne głowa w górę</p>	{}	{"Pectoralis major"}	{"Triceps brachii"}	11
91	Crunches	<p>Lay down on your back a soft surface, the feet are on the floor. Ask a partner or use some other help (barbell, etc.) to keep them fixed, your hands are behind your head. From this position move your upper body up till your head or elbows touch your knees. Do this movement by rolling up your back.</p>	{https://wger.de/media/exercise-images/91/Crunches-1.png,https://wger.de/media/exercise-images/91/Crunches-2.png}	{"Rectus abdominis"}	{"Serratus anterior"}	10
435	Dumbell Romanian Deadlift	<p>Romanian Deadlifts with dumbells in each hands instead of a barbell.</p>	{}	{}	{"Gluteus maximus"}	9
383	Hollow Hold	<p>Get on a mat and lie on your back. Contract your abs, stretch your raise and legs and raise them (your head and shoulders are also be raised). Make sure your lower back remains in contact with the mat.</p>	{}	{"Rectus abdominis","Obliquus externus abdominis"}	{}	10
319	Side Raise	<p>Stand up or sit , keep both weights in front against legs or at side. Keep arms at around a 90 degree angle. Lift elbows up slowly and squeese traps when at topmost position. Lower the weights slowly back to starting position.</p>\n<p>2 seconds up, 2 seconds down</p>	{}	{}	{}	13
442	Test	<p>test123jdhjkahdkajhjhjkdahjkahdjakhdak</p>	{}	{"Biceps femoris"}	{"Biceps femoris"}	10
127	Upright Row, SZ-bar	<p>Stand straight, your feet are shoulder-width apart. Hold the SZ-bar with an overhand grip on your thighs, the arms are stretched. Lift the bar close to the body till your chin. The elbows point out so that at the highest point they form a V. Make here a short pause before going slowly down and repeating the movement.</p>	{}	{"Anterior deltoid",Trapezius}	{"Biceps brachii"}	13
311	Upright Row w/ Dumbbells	<p>Feet apart at shoulder width. Nice and Slow!</p>	{}	{"Anterior deltoid",Trapezius}	{"Biceps brachii"}	13
307	Bear Walk	<p>-Rest your weight on your palms and the balls of your feet, not dissimilar to normal pushup position</p>\n<p>-Move by stepping with your R palm and L foot, then your L palm and R foot.  Basically, walk like a lumbering bear.</p>\n<p>-Move as fast as you can.  Measure your reps/sets in either distance (i.e. 40 yards) or time (i.e. 45 seconds)</p>\n<p>-Works your Pecs, Deltoids, Triceps, Traps, Lats, Abs and Lower Back, Hip Flexors, Quads, Glutes and Calves</p>	{}	{"Anterior deltoid","Serratus anterior","Pectoralis major","Rectus abdominis",Gastrocnemius,Soleus,"Triceps brachii"}	{"Gluteus maximus",Trapezius,"Quadriceps femoris","Latissimus dorsi","Obliquus externus abdominis"}	11
99	Butterfly Narrow Grip	<p>The movement is the same as with a regular butterfly, only that the grip is narrow:</p>\n<p>Sit on the butterfly machine, the feet have a good contact with the floor, the upper arms are parallel to the floor. Press your arms together till the handles are practically together (but aren't!). Go slowly back. The weights should stay all the time in the air.</p>	{}	{"Pectoralis major"}	{}	11
416	Crunches With Legs Up	<p>On your back, legs extended straight up, reach toward your toes with your hands and lift your shoulder blades off the ground and back.</p>	{}	{"Rectus abdominis"}	{"Obliquus externus abdominis"}	10
101	Decline Bench Press Dumbbell	<p>Take two dumbbells and sit on a decline bench, the feet are firmly on the floor, the head is resting the bench. Hold the weights next to the chest, at the height of your nipples and press them up till the arms are stretched. Let the weight slowly and controlled down.</p>	{}	{"Pectoralis major"}	{}	11
304	High Knee Jumps	<p>-Start with legs slightly wider than shoulder width</p>\n<p>-Drop into a bodyweight squat</p>\n<p>-As you hit the bottom of the squat, explode upwards into a jump while simultaneously tucking your knees into your chest midflight.  Remain tucked until the apex of your jump.</p>\n<p>-Land on both feet, making sure your knees are not locked so as to avoid excessive strain upon your joints.  Collect yourself into the next rep as quickly but under control as possible.</p>	{}	{Gastrocnemius,"Quadriceps femoris","Biceps femoris",Soleus}	{"Serratus anterior","Rectus abdominis","Obliquus externus abdominis"}	9
376	Hip Raise, Lying	Lying down on your back, with your feet flat on the floor. Raise your hips up evenly as high as you can and hold for as long as you can.	{}	{"Gluteus maximus","Biceps femoris"}	{"Rectus abdominis",Trapezius,"Latissimus dorsi","Obliquus externus abdominis"}	12
148	Lateral Raises	<p>.</p>	{https://wger.de/media/exercise-images/148/lateral-dumbbell-raises-large-2.png,https://wger.de/media/exercise-images/148/lateral-dumbbell-raises-large-1.png}	{"Anterior deltoid"}	{}	13
93	Negative Crunches	<p>Sit yourself on the decline bench and fix your legs. Cross your arms over the chest and bring with a rolling movement your upper body up, go now without a pause and with a slow movement down again. Don't let your head move during the exercise.</p>	{https://wger.de/media/exercise-images/93/Decline-crunch-1.png,https://wger.de/media/exercise-images/93/Decline-crunch-2.png}	{"Rectus abdominis"}	{}	10
238	Plank	<p>Get into a position on the floor supporting your weight on your forearms and toes. Arms are bent and directly below the shoulder. </p>\n<p>Keep your body straight at all times and hold this position as long as possible. To increase difficulty an arm or leg can be raised while performing this exercise.  </p>	{}	{"Rectus abdominis"}	{}	10
193	Preacher Curls	<p> Place the EZ curl bar on the rest handles in front of the preacher bench. Lean over the bench and grab the EZ curl bar with palms up. Sit down on the preacher bench seat so your upper arms rest on top of the pad and your chest is pressed against the pad. Lower the weight until your elbows are extended and arms are straight. Bring the weights back up to the starting point by contracting biceps. Repeat</p>	{https://wger.de/media/exercise-images/193/Preacher-curl-3-1.png,https://wger.de/media/exercise-images/193/Preacher-curl-3-2.png}	{Brachialis}	{Brachialis}	8
422	Side-lying External Rotation	<p>With a weight in one hand, lie on your side opposite the weight. Keep your knees slightly bent. Hold your elbow against your side, and extend your upper arm straight ahead of you. While continuing to hold your elbow against your side, rotate your upper arm 90 degrees upwards.</p>\n<p>It is helpful to place a towel under your armpit to help with the form on this exercise. Placing a support under your head for the duration of the exercise is also a good idea.</p>	{}	{}	{}	13
318	Turkish Get-Up	<p>Starting on back, move to the standing position with dumbbell in one hand.  Switch hands between reps.</p>	{}	{"Anterior deltoid","Serratus anterior","Gluteus maximus","Obliquus externus abdominis"}	{"Anterior deltoid","Serratus anterior","Gluteus maximus","Obliquus externus abdominis"}	10
124	Butterfly Reverse		{}	{"Anterior deltoid"}	{}	13
102	Standing Calf Raises	<p>Get onto the calf raises machine, you should able to completely push your calves down. Stand straight, don't make a hollow back and don't bend your legs. Pull yourself up as high as you can. Make a small pause of 1 - 2 seconds and go slowly down.</p>	{}	{Gastrocnemius}	{Soleus}	14
104	Calf Raises on Hackenschmitt Machine	<p>Place yourself on the machine with your back firmly against the backrest, the feet are on the platform for calf raises. Check that the feet are half free and that you can completely stretch the calf muscles down.</p>\n<p>With straight knees pull up your weight as much as you can. Go with a fluid movement down till the calves are completely stretched. Repeat.</p>	{}	{Gastrocnemius}	{Soleus}	14
348	Fentes Avant	<p>fentes avant buste droit ( quadriceps ) buste penché ( fessisers )</p>	{}	{}	{}	9
317	Hand Grip	<p>chrome Hand Flex Grip to build up forearms muscles</p>	{}	{}	{}	8
210	Incline Dumbbell Press	<ul>\n<li>Bench should be angled anywhere from 30 to 45 degrees</li>\n<li>Be sure to press dumbbells straight upward (perpendicular to the floor)</li>\n</ul>	{}	{"Pectoralis major"}	{}	11
165	Incline Plank With Alternate Floor Touch	<p>Perform the plank with legs elevated, feet on a gymball. Once stabilised, slowly move one foot sideways off the ball, then make it touch the floor, then come back to starting position. Alternate with the other foot.</p>\n<p>This is a core exercise.</p>	{}	{"Rectus abdominis"}	{"Obliquus externus abdominis"}	10
143	Long-Pulley (low Row)	<p>Sit down, put your feet on the supporting points and grab the bar with a wide grip. Pull the weight with a rapid movement towards your belly button, not upper. Keep your arms and elbows during the movement close to your body. Your shoulders are pulled together. Let the weight slowly down till your arms are completely stretched.</p>	{https://wger.de/media/exercise-images/143/Cable-seated-rows-2.png,https://wger.de/media/exercise-images/143/Cable-seated-rows-1.png}	{"Latissimus dorsi"}	{"Biceps brachii",Brachialis}	12
395	Reverse Dumbbell Flyes	<p>Works posterior deltoid muscle group does not appear in muscle list. Start with lower weight.</p>	{}	{}	{}	13
351	Romanian Deadlift	<p>DL from top to pos 2: https://www.youtube.com/watch?v=WtWtjViRsKo</p>	{}	{}	{}	9
325	Side Plank	<p>Works your obliques and helps stabilize your spine. Lie on your side and support your body between your forearm and knee to your feet.</p>	{}	{"Rectus abdominis"}	{"Obliquus externus abdominis"}	10
393	Upper Body	<p>Full workout of the upper arms body n chest. Focusing on the core</p>	{}	{"Biceps brachii","Anterior deltoid","Serratus anterior","Pectoralis major","Rectus abdominis",Trapezius,"Quadriceps femoris","Biceps femoris","Obliquus externus abdominis",Soleus,"Triceps brachii"}	{"Triceps brachii","Biceps brachii","Anterior deltoid","Serratus anterior","Pectoralis major","Rectus abdominis",Gastrocnemius,"Gluteus maximus",Trapezius,"Quadriceps femoris","Biceps femoris","Latissimus dorsi",Brachialis,"Obliquus externus abdominis",Soleus}	11
424	V-Bar Pulldown	<p>Pulldowns using close grip v-bar.</p>	{}	{}	{}	12
122	Fly With Cable		{https://wger.de/media/exercise-images/122/Incline-cable-flyes-1.png,https://wger.de/media/exercise-images/122/Incline-cable-flyes-2.png}	{"Pectoralis major"}	{}	11
380	LifeFitness Calf Extension Machine	Seated calf extension machine by LifeFitness	{}	{Gastrocnemius}	{Soleus}	14
141	MGM Machine		{}	{"Latissimus dorsi"}	{}	12
397	Run	<p>Running or jogging outside in a park, on the tracks,...</p>	{}	{}	{}	9
186	Triceps Bench Press One Barbell	<p>Činka v jedné ruce v úrovni ramene. Zvedat do výšky napnuté paže a zpět. Provádět pomalu.</p>	{}	{"Triceps brachii"}	{"Anterior deltoid"}	8
381	Deficit Deadlift	<p>Preparation</p>\n<p>Stand on weight plate, bumper plate, or shallow elevated platform with loaded bar above feet. Squat down and grasp bar with shoulder width or slightly wider overhand or mixed grip.</p>\n<p> </p>\n<p>Execution</p>\n<p>Lift bar by extending hips and knees to full extension. Pull shoulders back at top of lift if rounded. Return weights to floor by bending hips back while allowing knees to bend forward, keeping back straight and knees pointed same direction as feet. Repeat.</p>\n<p> </p>\n<p>Comments</p>\n<p>Throughout lift, keep hips low, shoulders high, arms and back straight. Knees should point same direction as feet throughout movement. Keep bar close to body to improve mechanical leverage. Grip strength and strength endurance often limit ability to perform multiple reps at heavy resistances. Gym chalk, wrist straps, grip work, and mixed grip can be used to enhance grip. Mixed grip indicates one hand holding with overhand grip and other hand holding with underhand grip. Lever barbell jack can be used to lift barbell from floor for easier loading and unloading of weight plates.</p>\n<p>Barbell Deficit Deadlift emphasizes building strength through lowest portion of Deadlift. Target muscle is exercised isometrically. Heavy barbell deadlifts significantly engages Latissmus Dorsi. See Barbell Deficit Deadlift under Gluteus Maximus. Also see Deadlift Analysis.</p>	{}	{}	{"Rectus abdominis","Gluteus maximus","Biceps femoris","Latissimus dorsi",Soleus}	12
138	Hammercurls on Cable	<p>Take a cable in your hands (palms parallel, point to each other), the body is straight. Bend the arms and bring the weight up with a fast movement. Without any pause bring it back down with a slow, controlled movement, but don't stretch completely your arms.</p>\n<p>Don't swing your body during the exercise, the biceps should do all the work here. The elbows are at your side and don't move.</p>	{https://wger.de/media/exercise-images/138/Hammer-curls-with-rope-1.png,https://wger.de/media/exercise-images/138/Hammer-curls-with-rope-2.png}	{"Biceps brachii"}	{Brachialis}	8
427	Russian Twist	<ol>\n<li>Lie down on the floor placing your feet either under something that will not move or by having a partner hold them. Your legs should be bent at the knees.</li>\n<li>Elevate your upper body so that it creates an imaginary V-shape with your thighs. Your arms should be fully extended in front of you perpendicular to your torso and with the hands clasped. This is the starting position.</li>\n<li>Twist your torso to the right side until your arms are parallel with the floor while breathing out.</li>\n<li>Hold the contraction for a second and move back to the starting position while breathing out. Now move to the opposite side performing the same techniques you applied to the right side.</li>\n<li>Repeat for the recommended amount of repetitions.</li>\n</ol>	{}	{}	{}	10
375	Tricep Push Down FreeWieghts	<p>Tricep Press down machine with free weights in free weight section</p>	{}	{}	{}	8
321	Weighted Step-ups	<p>box step ups w/ barbell and 45's on each side</p>	{}	{}	{}	9
129	Biceps Curl With Cable	<p>Stand around 30 - 40cm away from the cable, the feet are firmly on the floor. Take the bar and lift the weight with a fast movements. Lower the weight as with the dumbbell curls slowly and controlled.</p>	{https://wger.de/media/exercise-images/129/Standing-biceps-curl-1.png,https://wger.de/media/exercise-images/129/Standing-biceps-curl-2.png}	{"Biceps brachii"}	{}	8
145	Fly With Dumbbells	<p>Take two dumbbells and lay on a bench, make sure the feet are firmly on the ground and your back is not arched, but has good contact with the bench. The arms are stretched in front of you, about shoulder wide. Bend now the arms a bit and let them down with a half-circle movement to the side. Without changing the angle of the elbow bring them in a fluid movement back up.</p>	{}	{"Pectoralis major"}	{}	11
85	French Press (skullcrusher) Dumbbells	<p>Hold the dumbbells and lay down on a flat bench in such a way that around 1/4 of your head is over the edge. Stretch your arms with the weights and bend them so that the dumbbells are lowered (make sure they don't touch each other). Just before they touch your forehead, push them up.</p>\n<p>Pay attention to your elbows and arms: only the triceps are doing the work, the rest of the arms should not move.</p>	{}	{"Triceps brachii"}	{}	8
117	Leg Curls (sitting)		{https://wger.de/media/exercise-images/117/seated-leg-curl-large-1.png,https://wger.de/media/exercise-images/117/seated-leg-curl-large-2.png}	{"Biceps femoris"}	{}	9
269	Run - Treadmill	<p>Run on a treadmill</p>	{}	{}	{}	9
339	Shotgun Row	<ol>\n<li>Attach a single handle to a low cable.</li>\n<li>After selecting the correct weight, stand a couple feet back with a wide-split stance. Your arm should be extended and your shoulder forward. This will be your starting position.</li>\n<li>Perform the movement by retracting the shoulder and flexing the elbow. As you pull, supinate the wrist, turning the palm upward as you go.</li>\n<li>After a brief pause, return to the starting position.</li>\n</ol>	{}	{"Latissimus dorsi"}	{}	12
382	Standing Rope Forearm	<p>Grab a wrist roller tool with both hands while standing with your feet about shoulder width apart. If your gym does not have a wrist roller tool, you can easily put one together. All you need is a 5 or 10 pound weight plate, a strong thin rope about 3 feet long and a 6-8 inch stick or bar. Securely fasten the rope to the middle of the bar/stick and tie the other end of the rope to the weight plate. To begin this exercise, grab the bar/stick with both hands using an overhand grip. Extend both arms straight out in front of you, parallel to the floor. Next, roll the weight up from the floor by rapidly twisting the bar/stick with your hands and wrists. Once the weight reaches the top, slowly lower the plate back to the floor by reversing the motion of your hands and wrists. Repeat (if you can!).</p>	{}	{}	{}	8
329	Diagonal Shoulder Press	<p>You sit at the bench press device, back slightly tilted to the back. The bar should be about 20 cm in front of you. Then you push the bar and take it back again, as you would with a bench press.</p>\n<p>In this position you strain your chest muscles a lot less, which is nice if you want to train, but your chest hasn't recovered yet.</p>\n<p>Here's a link to a girl on a machine specialized for this exercise, to give a better description than my failing words above.</p>\n<p>http://www.schnell-online.de/db_imgs/products/img/t-80400.jpg</p>	{}	{}	{}	13
112	Dumbbell Lunges Standing	<p>.</p>	{}	{"Quadriceps femoris"}	{"Gluteus maximus"}	9
306	Lateral-to-Front Raises	<p>-(1) Perform a lateral raise, pausing at the top of the lift (2).</p>\n<p>-Instead of lowering the weight, bring it to the front of your body so that you appear to be at the top position of a front raise.  You will do this by using a Pec Fly motion, maintaining straight arms. (3)</p>\n<p>-Now lower the weight to your quadriceps, or, in other words, lower the dumbbells as though you are completing a Front Raise repetition. (4)</p>\n<p>-Reverse the motion:  Perform a front raise (5), at the apex of the lift use a Reverse Fly motion to position the weights at the top of a Lateral Raise (6), and finally, lower the weights until your palms are essentially touching the sides of your thighs (7).  THIS IS ONE REP.</p>\n<p>(1) l  <em>front view  </em>(2) -l- <em> FV  </em>  (3) l-  <em>side view</em>   (4) l  <em>SV/FV</em>   (5) l-  <em>SV  </em> (6) -l-  <em>FV  </em>  (7)  l  <em>FV/SV</em></p>	{}	{"Anterior deltoid",Trapezius}	{}	13
130	Leg Press on Hackenschmidt Machine		{https://wger.de/media/exercise-images/130/Narrow-stance-hack-squats-1-1024x721.png,https://wger.de/media/exercise-images/130/Narrow-stance-hack-squats-2-1024x721.png}	{"Quadriceps femoris"}	{}	9
337	Run	<p>3-5 Mi. Run </p>\n<p>Record Distance per Workout</p>	{}	{}	{}	9
430	Selectorized Seated Cable Row,	<p>đây là một động tác ăn vào cơ Lưng Giữa, những nhóm cơ ăn theo cũng rất nhiều là cơ lưng dưới, cơ xô và cơ tay trước.</p>	{}	{"Latissimus dorsi"}	{}	12
411	Skipping - Standard	<p>Do a single, double footed jump for each swing of the rope.</p>\n<p>Work on a smooth, rhythmical movement, bouncing lightly on the balls of your feet.</p>	{}	{Gastrocnemius}	{}	14
162	Triceps Dips	<p>lift on parallel bars hold for 1 second, and lower slowly and control for 4 seconds, then come back with no rest (tempo: 4010)</p>	{}	{"Triceps brachii"}	{}	8
213	Close-grip Lat Pull Down	<p>Grip the pull-down bar with your hands closer than shoulder width apart, with your palms facing away from you. Lean back slightly. Pull the bar down towards your chest, keeping your elbows close to your sides as you come down. Pull your shoulders back at the end of the motion.</p>	{}	{"Latissimus dorsi"}	{}	12
92	Crunches With Cable	<p>Take the cable on your hands and hold it next to your temples. Knee down and hold your upper body straight and bend forward. Go down with a fast movement, rolling your back in (your ellbows point to your knees). Once down, go slowly back to the initial position.</p>	{}	{"Rectus abdominis"}	{}	10
83	Dips Between Two Benches	<p>Put two benches so far appart, that you can hold onto one with your hands and are just able to reach the other with your feet. The legs stay during the exercise completely stretched. With your elbows facing back, bend them as much as you can. Push yourself up, but don't stretch out the arms.</p>	{https://wger.de/media/exercise-images/83/Bench-dips-1.png,https://wger.de/media/exercise-images/83/Bench-dips-2.png}	{"Triceps brachii"}	{}	8
431	Free Weight Lats Pulldown	<p>thay vì là thanh đòn thì bây giờ sẽ là 2 tay cầm , giúp bạn cơ động được nhiều hơn. Bài tập này chúng ta sẽ tập giống như bài Lats Pull Down nhưng thay vì kéo theo phương hơi xéo lên một tí thì bây giờ ở động tác này chúng ta sẽ kéo theo phương thẳng đứng. <strong>Kéo theo nhiều phương sẽ cho chúng ta những kích thích cơ khác nhau</strong>. <em>Đây là một bài tập rất tốt cho phần cơ xô. Khi ngồi vào chúng ta vẫn phải chỉnh ghế sao cho vừa vặn , khi kéo xuống chúng ta cố gắng kéo sao cho 2 tay cầm ra xa nhau một tí, về cách hít thở thì cũng như vậy, khi bắt đầu dùng lực thì vẫn hít vào và khi kết thúc lực sẽ thở ra. Tư thế bắt đầu sẽ là hai tay kẹp vào đầu , khi xuống các bạn ưỡn ngực ra một tí xíu. Các bạn có thể ngả ra một tí xíu nếu bạn thích.</em></p>	{}	{"Latissimus dorsi"}	{}	12
128	Hyperextensions	<p>Lay on the hyperextension pad with the belly button just at the leading edge, the upper body can hang freely. Tense your whole back's muscles and bring your upper body up till it is horizontal, but not more. Go slowly down and don't relax your muscles.</p>	{https://wger.de/media/exercise-images/128/Hyperextensions-1.png,https://wger.de/media/exercise-images/128/Hyperextensions-2.png}	{Trapezius}	{}	12
187	Lat Pull Down (Straight Back)	<p>Pull bar down to strenum and keep straight back.</p>	{}	{"Latissimus dorsi"}	{}	12
95	Sit-ups	<p>Sit on a mat, your calves are resting on a bench, the knees make a right angle. Hold your hands behind your neck. Go now up with a rolling movement of your back, you should feel how the individual vertebrae lose contact with the mat. At the highest point, contract your abs as much as you can and hold there for 2 sec. Go now down, unrolling your back.</p>\n<p> </p>	{}	{"Rectus abdominis"}	{}	10
139	Triceps Machine	<p>.</p>	{}	{"Triceps brachii"}	{}	8
387	Wall Squat	<p>Find a nice flat piece of wall and stand with your back leaning against the wall. Slowly slide down the wall while moving your feet away from it, until your thighs are parallel to the ground and both your knees and your hips are bent at a 90° angle. Cross your arms in front of your chest and hold this position for 30 seconds.</p>\n<p>Variant: put a big inflated rubber ball (like a small basketball) between your knees and squeeze the ball while holding the squat position</p>	{}	{"Quadriceps femoris","Biceps femoris"}	{}	9
181	Chin-ups	<p>Like pull-ups but with a reverse grip</p>	{https://wger.de/media/exercise-images/181/Chin-ups-2.png,https://wger.de/media/exercise-images/181/Chin-ups-1.png}	{"Biceps brachii","Latissimus dorsi"}	{}	12
303	Flutter Kicks	<p>-Laying on the back, lift your straightened legs from the ground at a 45 degree angle. </p>\n<p>-As your Left foot travels downward and nearly touches the floor, your Right foot should seek to reach a 90 degree angle, or as close to one as possible.</p>\n<p>-Bring your R foot down until it nearly touches the floor, and bring your L foot upwards.  Maintain leg rigidity throughout the exercise.  Your head should stay off the ground, supported by tightened upper abdominals.</p>\n<p>-(L up R down, L down R up, x2)  ^v, v^, ^v, v^ = 1 rep</p>\n<p>-Primarily works the Rectus Abdominus, the hip flexors and the lower back. Secondarily works the Obliques.  Emphasis placed on the lower quadrant of the abs.</p>\n<p> </p>	{}	{"Rectus abdominis","Obliquus externus abdominis"}	{}	10
84	French Press (skullcrusher) SZ-bar	<p>Hold the SZ-bar and lay down on a flat bench in such a way that around 1/4 of your head is over the edge. Stretch your arms with the bar and bend them so that the bar is lowered. Just before it touches your forehead, push it up.</p>\n<p>Pay attention to your elbows and arms: only the triceps are doing the work, the rest of the arms should not move.</p>	{https://wger.de/media/exercise-images/84/Lying-close-grip-triceps-press-to-chin-1.png,https://wger.de/media/exercise-images/84/Lying-close-grip-triceps-press-to-chin-2.png}	{"Triceps brachii"}	{}	8
154	Leg Curls (laying)	<p>Lay on a bench and put your calves behind the leg holder (better if they are hold on around the lower calves). Hold a grip on the bars to make sure the body is firmly in place. Bend your legs bringing the weight up, go slowly back. During the exercise the body should not move, all work is done by the legs.</p>	{https://wger.de/media/exercise-images/154/lying-leg-curl-machine-large-1.png,https://wger.de/media/exercise-images/154/lying-leg-curl-machine-large-2.png}	{"Biceps femoris"}	{}	9
208	Reverse Bar Curl	<p>Hold bar with reverse (or "overhand") grip, palms facing the floor.</p>	{}	{"Biceps brachii"}	{}	8
185	Squat Jumps	<p>Jump wide, then close</p>	{}	{"Quadriceps femoris"}	{}	9
90	Triceps Extensions on Cable With Bar	<p>Grab the bar, stand with your feet shoulder wide, keep your back straight and lean forward a little. Push the bar down, making sure the elbows don't move during the exercise. Without pause go back to the initial position.</p>	{}	{"Triceps brachii"}	{}	8
105	Deadlifts	<p>Stand firmly, with your feet slightly more than shoulder wide apart. Stand directly behind the bar where it should barely touch your shin, your feet pointing a bit out. Bend down with a straight back, the knees also pointing somewhat out. Grab the bar with a shoulder wide grip, one underhand, one reverse grip.</p>\n<p>Pull the weight up. At the highest point make a slight hollow back and pull the bar back. Hold 1 or 2 seconds that position. Go down, making sure the back is not bent. Once down you can either go back again as soon as the weights touch the floor, or make a pause, depending on the weight.</p>	{}	{"Quadriceps femoris","Latissimus dorsi"}	{"Gluteus maximus"}	12
164	High Pull	<p>Use a light barbell, perform explosive lift up starting from underneath knee cap level. Lift/raise explosively using hips, at shoulder level. Tempo: 2111</p>	{}	{"Anterior deltoid"}	{"Gluteus maximus"}	13
361	Pike Push Ups	<p>Push Up performed from a pike position (optional to have feet elevated).</p>	{}	{"Pectoralis major"}	{"Triceps brachii"}	8
\.


--
-- Data for Name: exercise_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY exercise_category (ec_id, name) FROM stdin;
10	Abs
8	Arms
12	Back
14	Calves
11	Chest
9	Legs
13	Shoulders
\.


--
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY program (p_id, name, description) FROM stdin;
\.


--
-- Name: program_p_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('program_p_id_seq', 1, false);


--
-- Data for Name: training_day; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY training_day (td_id, p_id, name, exercises) FROM stdin;
\.


--
-- Name: training_day_td_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('training_day_td_id_seq', 1, false);


--
-- Data for Name: training_result; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY training_result (tr_id, td_id, e_id, trained_on, rep_count, weight) FROM stdin;
\.


--
-- Name: training_result_tr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('training_result_tr_id_seq', 1, false);


--
-- Name: exercise_category exercise_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exercise_category
    ADD CONSTRAINT exercise_category_pkey PRIMARY KEY (ec_id);


--
-- Name: exercise exercise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exercise
    ADD CONSTRAINT exercise_pkey PRIMARY KEY (e_id);


--
-- Name: program program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY program
    ADD CONSTRAINT program_pkey PRIMARY KEY (p_id);


--
-- Name: training_day training_day_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY training_day
    ADD CONSTRAINT training_day_pkey PRIMARY KEY (td_id);


--
-- Name: training_result training_result_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY training_result
    ADD CONSTRAINT training_result_pkey PRIMARY KEY (tr_id);


--
-- Name: training_result training_result_e_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY training_result
    ADD CONSTRAINT training_result_e_id_fkey FOREIGN KEY (e_id) REFERENCES exercise(e_id);


--
-- Name: training_result training_result_td_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY training_result
    ADD CONSTRAINT training_result_td_id_fkey FOREIGN KEY (td_id) REFERENCES training_day(td_id);


--
-- PostgreSQL database dump complete
--

