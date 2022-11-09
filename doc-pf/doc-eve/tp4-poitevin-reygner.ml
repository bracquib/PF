(* POITEVIN Eve & REYGNER Etienne *)

#load "qtparser.cmo"
open Qtparser

let smiley = Noeud(Noeud(Feuille 0, Feuille 0, Noeud(Feuille 1, Feuille 0, Feuille 0, Feuille 1), Feuille 0), Noeud( Feuille 0, Feuille 0, Feuille 0, Noeud(Feuille 0, Feuille 1, Feuille 1, Feuille 0)), Noeud( Noeud(Feuille 0, Feuille 0, Feuille 1, Feuille 0), Feuille 0, Feuille 0, Noeud(Feuille 1, Feuille 0, Feuille 0, Feuille 0)), Noeud (Feuille 0, Noeud(Feuille 0, Feuille 0, Feuille 0, Feuille 1), Noeud(Feuille 0, Feuille 1, Feuille 0, Feuille 0), Feuille 0));;

save_qt 8 2 smiley "dessin.pgm"
let q2 = load_qt "dessin.pgm"

(* Exercice 59 *)

let rec rot_pos = fun q -> match q with
                           | Feuille(c) -> Feuille(c)
                           | Noeud(c1, c2, c3, c4) -> Noeud(rot_pos c2, rot_pos c3, rot_pos c4, rot_pos c1);;

save_qt 8 2 (rot_pos smiley) "dessin_rot_p.pgm"
let q3 = load_qt "dessin_rot_p.pgm"

(* Exercice 60 *)

let rec rot_neg = fun q -> match q with
                           | Feuille(c) -> Feuille(c)
                           | Noeud(c1, c2, c3, c4) -> Noeud(rot_neg c4, rot_neg c1, rot_neg c2, rot_neg c3);;

save_qt 8 2 (rot_neg smiley) "dessin_rot_n.pgm"
let q4 = load_qt "dessin_rot_n.pgm"

(* Exercice 61 *)

let rec miroir_hori = fun q -> match q with
                               | Feuille(c) -> Feuille(c)
                               | Noeud(c1, c2, c3, c4) -> Noeud(miroir_hori c4, miroir_hori c3, miroir_hori c2, miroir_hori c1);;

save_qt 8 2 (miroir_hori smiley) "dessin_hori.pgm"
let q5 = load_qt "dessin_hori.pgm"

(* Exercice 62 *)

let rec miroir_vert = fun q -> match q with
                               | Feuille(c) -> Feuille(c)
                               | Noeud(c1, c2, c3, c4) -> Noeud(miroir_vert c2, miroir_vert c1, miroir_vert c4, miroir_vert c3);;

save_qt 8 2 (miroir_vert smiley) "dessin_vert.pgm"
let q6 = load_qt "dessin_vert.pgm"

(* Exercice 63 *)

let rec inversion_video = fun q x -> match q with
                                     | Feuille(c) -> if c=0 then Feuille(x) else Feuille(0)
                                     | Noeud(c1, c2, c3, c4) -> Noeud(inversion_video c1 x, inversion_video c2 x, inversion_video c3 x, inversion_video c4 x);;

save_qt 8 2 (inversion_video smiley 1) "dessin_invert.pgm"
let q7 = load_qt "dessin_invert.pgm"

(* Exercice 64 *)

let rec max_gris = fun q -> match q with
                            | Feuille(c) -> c
                            | Noeud(c1, c2, c3, c4) -> max ( max (max_gris c1) (max_gris c2)) (max(max_gris c3) (max_gris c4));;

(* Exercice 65 *)

let rec compare = fun q1 q2 -> match q1, q2 with
                               | Feuille(c_q1), Feuille(c_q2) -> c_q1=c_q2
                               | Noeud(c1_q1, c2_q1, c3_q1, c4_q1), Noeud(c1_q2, c2_q2, c3_q2, c4_q2) -> (compare c1_q1 c1_q2) && (compare c2_q1 c2_q2) && (compare c3_q1 c3_q2) && (compare c4_q1 c4_q2)
                               | Noeud(c1_q1, c2_q1, c3_q1, c4_q1), Feuille(c_q2) -> c1_q1=Feuille(c_q2) && c2_q1=Feuille(c_q2) && c3_q1=Feuille(c_q2) && c4_q1=Feuille(c_q2)
                               | Feuille(c_q2), Noeud(c1_q1, c2_q1, c3_q1, c4_q1) -> c1_q1=Feuille(c_q2) && c2_q1=Feuille(c_q2) && c3_q1=Feuille(c_q2) && c4_q1=Feuille(c_q2);;

compare smiley smiley;;

compare smiley (miroir_hori smiley);;


(* Exercice 67 *)

let rec min_quad = fun q -> match q with
    | Noeud(Feuille(c_q1), Feuille(c_q2), Feuille(c_q3), Feuille(c_q4)) -> if c_q1 = c_q2 && c_q2 = c_q3 && c_q3 = c_q4 then Feuille(c_q1) else q
    | Noeud(c_q1, c_q2, c_q3, c_q4) -> let cq1 = min_quad c_q1 and cq2 = min_quad c_q2 and cq3 = min_quad c_q3 and cq4 = min_quad c_q4 in
                                        if compare cq1 cq2 && compare cq2 cq3 && compare cq3 cq4 then cq1 else Noeud(cq1, cq2, cq3, cq4)
    | _ -> q;;

let smiley_quad = Noeud (Noeud (Noeud (Feuille 0, Feuille 0, Feuille 0, Feuille 0), Feuille 0, Noeud(Feuille 1, Feuille 0, Feuille 0, Feuille 1), Feuille 0), Noeud( Feuille 0, Feuille 0, Feuille 0, Noeud(Feuille 0, Feuille 1, Feuille 1, Feuille 0)), Noeud( Noeud(Feuille 0, Feuille 0, Feuille 1, Feuille 0), Feuille 0, Feuille 0, Noeud(Feuille 1, Feuille 0, Feuille 0, Feuille 0)), Noeud (Feuille 0, Noeud(Feuille 0, Feuille 0, Feuille 0, Feuille 1), Noeud(Feuille 0, Feuille 1, Feuille 0, Feuille 0), Feuille 0));;

min_quad smiley_quad;;

compare smiley smiley_quad;;
