(deffunction ask-value (?question)
    (print ?question)
    (bind ?answer (read))
    ?answer
    )

(deffunction ask-question (?question $?allowed-values)
    (print ?question)
    (bind ?answer (read))
    (if (lexemep ?answer)
        then (bind ?answer (lowcase ?answer))
	    )
    (while (not (member$ ?answer ?allowed-values)) do
        (print ?question)
        (bind ?answer (read))
        (if (lexemep ?answer)
            then (bind ?answer (lowcase ?answer))
		    )
	    )
    ?answer
    )

(deffunction yes-or-no (?question)
    (bind ?response (ask-question ?question yes no y n))
        (if (or (eq ?response yes) (eq ?response y))
            then yes
            else no
        )
)

(defrule ask-for-age "СПРОСИТЬ ВОЗРАСТ (AGE)"
    (not (solution ?))
    (not (age ?))
    =>
    (assert (age (ask-value "Сколько тебе лет? Ответ: ")))
)

(defrule ask-if-likes-spies "СПРОСИТЬ, НРАВИТСЯ ЛИ ШПИОНАЖ (LIKES-SPIES)"
    (not (solution ?))
    (not (likes-spies ?))
    =>
    (assert (likes-spies (yes-or-no "Тебе нравится шпионаж? (yes/no): ")))
)

(defrule ask-if-read-sharp-objects "СПРОСИТЬ, ЧИТАЛ ЛИ SHARP OBJECTS (READ-SHARP-OBJECTS)"
    (not (solution ?))
    (not (read-sharp-objects ?))
    =>
    (assert (read-sharp-objects (yes-or-no "Ты читал Острые Предметы? (yes/no): ")))
)

(defrule ask-if-watched-mulholland-drive "СПРОСИТЬ, СМОТРЕЛ ЛИ MULHOLLAND DRIVE (WATCHED-MULHOLLAND-DRIVE)"
    (not (solution ?))
    (not (watched-mulholland-drive ?))
    =>
    (assert (watched-mulholland-drive (yes-or-no "Ты смотрел фильм Mulholland Drive? (yes/no): ")))
)

(defrule ask-if-likes-robinzonada "СПРОСИТЬ, НРАВИТСЯ ЛИ РОБИНЗОНАДА (LIKES-ROBINZONADA)"
    (not (solution ?))
    (not (likes-robinzonada ?))
    =>
    (assert (likes-robinzonada (yes-or-no "Тебе нравится робинзонада? (yes/no): ")))
)

(defrule ask-if-likes-sea-theme "СПРОСИТЬ, НРАВИТСЯ ЛИ МОРСКАЯ ТЕМА (LIKES-SEA-THEME)"
    (not (solution ?))
    (not (likes-sea-theme ?))
    =>
    (assert (likes-sea-theme (yes-or-no "Тебе нравится морская тематика? (yes/no): ")))
)

(defrule ask-if-likes-adventure "СПРОСИТЬ, НРАВЯТСЯ ЛИ ПРИКЛЮЧЕНИЯ (LIKES-ADVENTURE)"
    (not (solution ?))
    (not (likes-adventure ?))
    =>
    (assert (likes-adventure (yes-or-no "Тебе нравятся приключения? (yes/no): ")))
)

(defrule ask-if-played-wow "СПРОСИТЬ, ИГРАЛ ЛИ В WORLD OF WARCRAFT (PLAYED-WOW)"
    (not (solution ?))
    (not (played-wow ?))
    =>
    (assert (played-wow (yes-or-no "Ты играл в World of Warcraft? (yes/no): ")))
)

(defrule ask-if-likes-flying-pirates "СПРОСИТЬ, НРАВЯТСЯ ЛИ ЛЕТАЮЩИЕ ПИРАТЫ (LIKES-FLYING-PIRATES)"
    (not (solution ?))
    (not (likes-flying-pirates ?))
    =>
    (assert (likes-flying-pirates (yes-or-no "Тебе нравятся летающие пираты? (yes/no): ")))
)

(defrule ask-if-likes-time-machine "СПРОСИТЬ, НРАВИТСЯ ЛИ МАШИНА ВРЕМЕНИ (LIKES-TIME-MACHINE)"
    (not (solution ?))
    (not (likes-time-machine ?))
    =>
    (assert (likes-time-machine (yes-or-no "Тебе нравятся машины времени? (yes/no): ")))
)

(defrule ask-if-watched-hunger-games "СПРОСИТЬ, СМОТРЕЛ ЛИ ГОЛОДНЫЕ ИГРЫ (WATCHED-HUNGER-GAMES)"
    (not (solution ?))
    (not (watched-hunger-games ?))
    =>
    (assert (watched-hunger-games (yes-or-no "Ты смотрел Голодные Игры? (yes/no): ")))
)

(defrule ask-if-likes-pseudoscience "СПРОСИТЬ, НРАВИТСЯ ЛИ ПСЕВДОНАУКА (PSEUDOSCIENCE)"
    (not (solution ?))
    (not (likes-pseudoscience ?))
    =>
    (assert (likes-pseudoscience (yes-or-no "Тебе нравится псевдонаука? (yes/no): ")))
)

(defrule ask-if-from-russia "СПРОСИТЬ, ЧИТАТЕЛЬ ИЗ РОССИИ (FROM-RUSSIA)"
    (not (solution ?))
    (not (from-russia ?))
    =>
    (assert (from-russia (yes-or-no "Ты из России? (yes/no): ")))
)

(defrule ask-if-hates-russia "СПРОСИТЬ, ИСПЫТЫВАЕТ ЛИ НЕНАВИСТЬ К РОССИИ (HATES-RUSSIA)"
    (not (solution ?))
    (not (hates-russia ?))
    =>
    (assert (hates-russia (yes-or-no "Ты испытываешь ненависть к России? (yes/no): ")))
)

(defrule result-woman-in-the-window "RULE 1. Result = Эй Джей Финн - Женщина в окне"
    (not (solution ?))
    (likes-thrillers yes)
    (acceptable-mental-illness yes)
    =>
    (assert (solution yes))
    (print "Рекомендую книгу: Эй Джей Финн - Женщина В Окне" crlf)
)

(defrule rule-likes-thrillers "RULE 2. НРАВЯТСЯ ТРИЛЛЕРЫ"
    (likes-spies yes)
    (likes-detectives yes)
    =>
    (assert (likes-thrillers yes))
    (print "Предполагаю, что тебе нравятся триллеры" crlf) )

(defrule rule-likes-detectives "RULE 3. НРАВЯТСЯ ДЕТЕКТИВЫ"
    (read-sharp-objects ?read)
    (age ?value)
    =>
    if (and (eq read yes) (> ?value 18))
    then (and
        (assert (likes-detectives yes))
        (print "Думаю, тебе нравятся детективы" crlf) ) )

(defrule rule-acceptable-mental-illness "RULE 4. ПСИХИЧЕСКИЕ ОТКЛОНЕНИЯ ПРИЕМЛЕМЫ"
    (watched-mulholland-drive ?m_drive)
    (age ?value)
    =>
    if (and (eq m_drive yes) (> ?value 16))
    then (and
        (assert (acceptable-mental-illness yes))
        (print "Думаю, тема психических отклонений приемлема" crlf) ) )

(defrule result-secret-island "RULE 5. RESULT = ЖУЛЬ ВЕРН - ТАИНСТВЕННЫЙ ОСТРОВ"
    (not (solution ?))
    (likes-robinzonada yes)
    (likes-pirates yes)
    =>
    (assert (solution yes))
    (print "Рекомендую книгу: Жуль Верн - Таинственный Остров" crlf) )

(defrule rule-likes-pirates "RULE 6. LIKES-PIRATES"
    (or (likes-fantasy yes)
        (likes-sea-adventure))
    =>
    (assert (likes-pirates yes))
    (print "Думаю, тебе понравятся пираты" crlf) )

(defrule rule-likes-sea-adventure "RULE 7. LIKES SEA-ADVENTURE"
    (likes-sea-theme yes)
    (likes-adventure yes)
    =>
    (assert (likes-sea-adventure yes))
    (print "Думаю, тебе понравятся морские приключения" crlf) )

(defrule rule-likes-fantasy "RULE 8. LIKES FANTASY"
    (played-wow ?)
    (age ?value)
    =>
    if (and (eq played-wow yes) (> ?value 15))
    then (and
        (assert (likes-fantasy yes))
        (print "Думаю, тебе понравится жанр фэнтези" crlf) ) )


(defrule result-spread-wings "RULE 9. RESULT = Ольга Голотвина - Крылья распахнуть!"
    (not (solution ?))
    (likes pirates yes)
    (likes-flying-pirates yes)
    =>
    (assert (solution yes))
    (print "Рекомендую книгу: Ольга Голотвина - Крылья распахнуть" crlf) )

(defrule result-time-machine "RULE 10. РЕЗУЛЬТАТ = ГЕРБЕРГ УЭЛЛС - МАШИНА ВРЕМЕНИ"
    (not (solution ?))
    (likes-time-machine yes)
    (likes-chronofantasy yes)
    =>
    (assert (solution yes))
    (print "Рекомендую книгу: Герберт Уэллс - Машина Времени" crlf) )

(defrule rule-likes-chronofantasy "RULE 11. LIKES CHRONOFANTASY"
    (likes-travel yes)
    (likes-time-travel yes)
    =>
    (assert (likes-chronofantasy yes))
    (print "Думаю, тебе понравятся хронофантастика" crlf) )

(defrule rule-likes-travel "RULE 12. LIKES TRAVEL"
    (or (likes-adventure yes)
        (watched-hunger-games yes) )
    =>
    (assert (likes-travel yes))
    (print "Думаю, тебе понравятся путешествия" crlf) )

(defrule rule-likes-time-travel "RULE 13. LIKES TIME TRAVEL"
    (likes-adventure yes)
    (likes-pseudoscience yes)
    =>
    (assert (likes-time-travel yes))
    (print "Думаю, тебе понравятся путешествия во времени" crlf) )

(defrule result-left-alone "RULE 14. РЕЗУЛЬТАТ = И ТОГДА ОН ОСТАЛСЯ ОДИН"
    ( not (solution ?))
    (likes-chronofantasy yes)
    (likes-russian-setting yes)
    =>
    (assert (solution yes))
    (print "Рекомендую книгу: Иван Мартынов - И Тогда Он Остался Один" crlf)
)

(defrule rule-likes-russian-setting "RULE 15. НРАВИТСЯ РУССКИЙ СЭТТИНГ"
    (not (solution ?))
    (from-russia ?russian)
    (hates-russia ?hate)
    =>
    if (or (eq ?russian yes) (eq ?hate no))
    then (and
        (assert (likes-russian-setting yes))
        (print "Думаю, тебе понравится русский сэттинг" crlf) )
)
