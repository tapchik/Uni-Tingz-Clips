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

(defrule determine-likes-genre-fantasy
    (not (solution ?))
    (age ?value)
    =>
    (if (> ?value 15)
        then (and
            (assert (likes-genre-fantasy yes))
            (print "Думаю, тебе нравится жанр фантастика" crlf)
        ) else (
            (assert (likes-genre-fantasy no))
            (print "Думаю, тебе не нравится жанр фантастика" crlf)
        )
    )
)

(defrule determine-likes-genre-sea-adventure
    (not (solution ?))
    (not (likes-genre-sea-adventure ?))
    (likes-sea-theme ?sea)
    (likes-adventure ?adventure)
    =>
    (if (and (eq ?sea yes) (eq ?adventure yes))
        then (and
            (assert (like-genre-sea-theme yes))
            (print "You probably like sea adventures" crlf)
        ) else (and
            (assert (like-genre-sea-theme no))
            (print "You probably don't like sea adventures" crlf)
        )
    )
)
