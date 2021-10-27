\NeedsTeXFormat{LaTeX2e}[1998/12/01]
\ProvidesClass{memoire-umons}[2009/05/05 v0.1 ^^J
  \space
  Memoires de l'Université de Mons.]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            O P T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO: Option "print" to disable the colors for the
\newif\ifumons@print \umons@printfalse
\DeclareOption{print}{\umons@printtrue}

\newif\ifumons@draft \umons@draftfalse
\DeclareOption{draft}{%
  \umons@drafttrue
  \PassOptionsToClass{draft}{book}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ProcessOptions
\LoadClass{book}

% \addtolength{\textwidth}{2cm}
% \addtolength{\oddsidemargin}{-1cm}
% \addtolength{\textheight}{2cm}
% \setlength{\parindent}{0pt}

\RequirePackage{amsthm,aliascnt}
\RequirePackage{amssymb}
\RequirePackage{translator}

\RequirePackage{graphics}
% For the logos (use `xcolor' to avoid warnings if `xcolor' is used in
% the document, e.g. with Tikz).  `xcolor' is not present in all distrib.
%\PassOptionsToPackage{rgb}{xcolor}
\AtBeginDocument{%
  \IfFileExists{xcolor.sty}{%
    \RequirePackage{xcolor}}{%
    \RequirePackage{color}}%

  \definecolor{umonsgreen}{rgb}{0.56862745,0.78039216,0.63137255}
  \definecolor{umonsdarkgreen}{rgb}{0.4,0.47,0.42}
  \definecolor{umonsblue}{rgb}{0.23,0.85,0.98}
  \definecolor{umonsdarkblue}{rgb}{0.23,0.33,0.95}
  \definecolor{umonsmetalblue}{rgb}{0.21,0.67,0.61}
  \definecolor{umonsred}{RGB}{168, 0, 57}
  \definecolor{umonsgray}{RGB}{150, 150, 150}
  \definecolor{umonsturquoise}{RGB}{0, 171, 204}
}

\ifumons@draft
\setlength{\overfullrule}{10pt}
%\errorcontextlines=10 % debugging
\fi

%% Compatibility

\@ifundefined{AddToHook}{%
  \RequirePackage{etoolbox}
  \let\umons@AfterBeginDocument=\AfterEndPreamble
}{
  \newcommand*{\umons@AfterBeginDocument}[1]{%
    \AddToHook{begindocument/end}{#1}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                              P D F
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%
  \@ifundefined{hypersetup}{}{%
    \hypersetup{%
      pdftitle={\@title},%
      pdfauthor={\@author\space (University of Mons)},%
      pdfsubject={Master's Thesis},%
      %pdfkeywords={},
      plainpages=false, % => page.i <> page.1
      colorlinks=true,
      pdfstartview=FitH,
      % pdfmenubar=false
    }%
    \ifumons@print
    \hypersetup{%
      urlcolor=black,
      citecolor=black,
      linkcolor=black,
    }%
    \else
    \hypersetup{%
      urlcolor=umonsdarkgreen,
      citecolor=umonsdarkblue,
      linkcolor=umonsred,
    }%
    \fi
  }}

\newif\ifpdf@umons
\@ifundefined{pdfoutput}{%
  \pdf@umonsfalse
}{%
  \ifnum\pdfoutput<1 % => not generating pdf
    \pdf@umonsfalse
  \else
    \pdf@umonstrue
  \fi
}

\ifpdf@umons\else
\providecommand{\Hy@colorlink}[1]{}
\providecommand{\Hy@endcolorlink}{}
\fi

\AtBeginDocument{\providecommand{\texorpdfstring}[2]{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                     T R A N S L A T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providetranslation[to=english]{Supervisor}{Supervisor}
\providetranslation[to=english]{Supervisors}{Supervisors}
\providetranslation[to=english]{Co-supervisors}{Co-supervisors}
\providetranslation[to=english]{umons@team}{Team}
\providetranslation[to=english]{umons@teams}{Teams}
\providetranslation[to=english]{umons@mathematics}{Mathematics}
\providetranslation[to=english]{Department of Mathematics}{%
  Department of Mathematics}
\providetranslation[to=english]{Faculty of Sciences}{Faculty of Sciences}
\providetranslation[to=english]{University of Mons}{University of Mons}
\providetranslation[to=english]{Master's Thesis submitted by}{%
  Master's Thesis submitted by}
\providetranslation[to=english]{umons@obtain@master}{%
  With a view of getting the degree of Master in}
\providetranslation[to=english]{Academic Year}{Academic Year}
\providetranslation[to=english]{umons@Equation}{Equation}
\providetranslation[to=english]{umons@Theorem}{Theorem}
\providetranslation[to=english]{umons@Proposition}{Proposition}
\providetranslation[to=english]{umons@Lemma}{Lemma}
\providetranslation[to=english]{umons@Corollary}{Corollary}
\providetranslation[to=english]{umons@Definition}{Definition}
\providetranslation[to=english]{umons@Remark}{Remark}

\providetranslation[to=french]{Supervisor}{Directeur}
\providetranslation[to=french]{Supervisors}{Directeurs}
\providetranslation[to=french]{Co-supervisors}{Co-directeurs}
\providetranslation[to=french]{umons@team}{Service}
\providetranslation[to=french]{umons@teams}{Services}
\providetranslation[to=french]{umons@mathematics}{sciences math\'ematiques}
\providetranslation[to=french]{Department of Mathematics}{%
  D\'epartement de Math\'ematique}
\providetranslation[to=french]{Faculty of Sciences}{Facult\'e des Sciences}
\providetranslation[to=french]{University of Mons}{Universit\'e de Mons}
\providetranslation[to=french]{Master's Thesis submitted by}{%
  M\'emoire r\'ealis\'e par}
\providetranslation[to=french]{umons@obtain@master}{%
  pour l'obtention du dipl\^ome de Master en}
\providetranslation[to=french]{Academic Year}{Ann\'ee acad\'emique}
\providetranslation[to=french]{umons@Equation}{\'equation}
\providetranslation[to=french]{Theorem}{Th\'eor\`eme}
\providetranslation[to=french]{Lemma}{Lemme}
\providetranslation[to=french]{Corollary}{Corollaire}
\providetranslation[to=french]{Definition}{D\'efinition}
\providetranslation[to=french]{Remark}{Remarque}
\providetranslation[to=french]{umons@Theorem}{th\'eor\`eme}
\providetranslation[to=french]{umons@Proposition}{proposition}
\providetranslation[to=french]{umons@Lemma}{lemme}
\providetranslation[to=french]{umons@Corollary}{corollaire}
\providetranslation[to=french]{umons@Definition}{d\'efinition}
\providetranslation[to=french]{umons@Remark}{remarque}

\AtBeginDocument{%
  \translatelet{\@discipline}{umons@mathematics}
  \translatelet{\@department}{Department of Mathematics}
  \translatelet{\memoire@faculte}{Faculty of Sciences}
  \translatelet{\memoire@universite}{University of Mons}
  \def\memoire@realise{%
    \translate{Master's Thesis submitted by} \@author\\
    \translate{umons@obtain@master} \@discipline}
}

\begingroup
\catcode`\:=\active
\gdef\umons@activecolon{:}% For e.g. French (or other languages)
\gdef:{\string:}% Default value of the macro
\endgroup

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                    P A G E   D E   G A R D E
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@directeur{}
\newcommand{\directeur}[1]{%
  \def\@directeur{#1}%
  \translatelet{\@directeur@name}{Supervisor}}
\newcommand{\directeurs}[1]{%
  \def\@directeur{#1}%
  \translatelet{\@directeur@name}{Supervisors}}
\newcommand{\codirecteurs}[1]{%
  \def\@directeur{#1}%
  \translatelet{\@directeur@name}{Co-supervisors}}
\def\umons@service{}
\newcommand{\service}[1]{%
  \def\umons@service{#1}%
  \translatelet{\@service@name}{umons@team}}
\newcommand{\services}[1]{%
  \def\umons@service{#1}%
  \translatelet{\@service@name}{umons@teams}}

\newcommand{\discipline}[1]{\def\@discipline{#1}}
\newcommand{\departement}[1]{\def\@department{#1}}
\def\@date{}

\def\umons@logofac{UMONS_FS}
\newcommand{\logofac}[1]{\def\umons@logofac{#1}}

\newcommand{\umons@notempty}[3]{{%
    \def\\{}% (locally)
    \ifx #1\empty \PackageError{memoire-umons}{%
      Pas de #2.^^J\space\space Utilisez la commande `\protect
      #3{...}'  pour specifier sa valeur}{}%
    \fi }}

\newcommand{\bottomsep}{%
  \hspace{0.5em}\raisebox{0.1ex}{\rotatebox{45}{\rule{0.7ex}{0.7ex}}}%
  \hspace{0.5em}\ignorespaces}

\renewcommand{\maketitle}{%
  \renewcommand{\thepage}{\Roman{page}}% => no clash for PDF links
  % Checks:
  \umons@notempty{\@directeur}{directeur}{\directeur}%
  \umons@notempty{\umons@service}{service}{\service}%
  \umons@notempty{\@date}{d'annee academique}{\date}%
  \begin{titlepage}
    % Le logo DOIT être en haut à droite du document
    \addtolength{\hoffset}{5mm}% recenter slightly (local to this page)
    \noindent
    \smash{\raisebox{13mm}{\hbox to \textwidth{%
          \hspace{-8mm}%
          % \resizebox{!}{15mm}{\includegraphics{Sciences-gray}}%
          \fontfamily{phv}\fontsize{9}{12}\selectfont
          % http://dante.ctan.org/CTAN/fonts/winfonts/
          % \fontfamily{verdana}\selectfont
          \color{umonsgray}
          %\ifpdf@umons
          \begin{tabular}[t]{@{}l@{}}
            % \resizebox{!}{20mm}{\includegraphics{lorentz}}\\[-5mm]
            \ifx \umons@logofac\empty \else
              \resizebox{!}{15mm}{\includegraphics{\umons@logofac}}\\[3pt]%
            \fi
            \@department
          \end{tabular}%
          %\fi
          \hfill        
          % \vrule width 0.3pt height 11mm depth 4mm % (test)
          %\raisebox{-3.6mm}{% Sciences
          \raisebox{0mm}{%
            \resizebox{!}{15mm}{\includegraphics{UMONS+txt}}
            %\resizebox{!}{15mm}{\includegraphics{UMONS}}
            % To adjust elements visually:
            %\llap{\raisebox{3mm}{\vrule width 30cm height 0pt depth 0.3pt}}%
            %\llap{\raisebox{15mm}{\vrule width 30cm height 0pt depth 0.3pt}}%
          }%
          \hspace{-24mm}%
        }}}%
    \vspace{10em}
    \begin{center}
      \vspace{-5mm}
      {\bfseries\sffamily
        \fontsize{30}{40}\fontfamily{phv}\selectfont % Helvetica
        \@title
        \\[1.5ex]}%
      \fontsize{12}{14}\fontfamily{ptm}\selectfont %
      \memoire@realise
      
      \vfill
      \begin{tabular}[t]{@{}r@{ }l@{}}
        \textbf{\@service@name\umons@activecolon}&
        \begin{tabular}[t]{@{}l@{}} \umons@service \end{tabular}%
        \\[2\jot]
        \textbf{\@directeur@name\umons@activecolon}&
        \begin{tabular}[t]{@{}l@{}} \@directeur \end{tabular}%
      \end{tabular}
      \\
      \vfill\vfill\vfill
      \translate{Academic Year} \@date\par
      \vfill
      \smash{\raisebox{-23mm}{\vtop{%
            %\centerline{\resizebox{!}{15mm}{\includegraphics{Acad-logoumh}}}
            \memoire@faculte\bottomsep
            \memoire@universite\bottomsep
            Place du Parc 20\bottomsep
            B-7000 Mons %(Belgium)
          }}}%
    \end{center}
  \end{titlepage}
  \newpage
  \thispagestyle{empty}
  \null % No content
  \newpage
  % Roman numbered pages: 
  \setcounter{page}{1}%
  \renewcommand{\thepage}{\arabic{page}}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                              T O C
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\tableofcontents}{%
  \if@twocolumn \@restonecoltrue \onecolumn \else \@restonecolfalse\fi
  \chapter*{\contentsname
    \@mkboth {\textsl{\contentsname}}{%
      \textsl{\contentsname}}}%
  \@starttoc {toc}\if@restonecol \twocolumn \fi
  \newpage
  \@mkboth{}{}% many students do not understand what happens otherwise...
}

% Redefine the numering of content lines because the Roman numbering
% may go into the text.
\renewcommand{\numberline}[1]{%
  % \@tempdima contains the width of the box for the number.
  \settowidth{\@tempdimb}{#1\hspace{0.8ex}}%
  \ifdim \@tempdimb > \@tempdima  {#1}\hspace{1ex}%
  \else  \hb@xt@ \@tempdima {#1\hfil}%
  \fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                          P R E F A C E
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{preface}{%
  % Pages for the document:
  \ifnum \value{page} > 1
  \PackageError{memoire-umons}{%
    L'environnement `preface' doit commencer en page 1.}{}%
  \fi
  \renewcommand{\thepage}{\roman{page}}%
}{%
  \newpage
  % Pages for the document:
  \setcounter{page}{1}%
  \renewcommand{\thepage}{\arabic{page}}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                       C H A P T E R S ...
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{%
  \ifnum\value{chapter}>0 \thechapter .\fi
  \arabic{section}}

\renewcommand{\@makechapterhead}[1]{%
  \vspace*{50\p@}{%
    \parindent \z@
    \raggedright \normalfont \sffamily
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \huge \bfseries \@chapapp \space \thechapter \par
        \nobreak \vskip 20\p@
      \fi
    \fi
    \interlinepenalty \@M
    \Huge \bfseries #1\par
    \nobreak \vskip 40\p@}}

\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{50\p@ }{%
    \parindent \z@
    \raggedright \normalfont \sffamily
    \interlinepenalty \@M
    \Huge \bfseries #1\par
    \nobreak \vskip 40\p@}}

\renewcommand{\chaptermark}[1]{%
  \markboth{\textsl{\@chapapp \space \thechapter\ ---\ #1}}{%
    \textsl{\@chapapp \space \thechapter\ ---\ #1}}}

\renewcommand{\section}{%
  \@startsection {section}{1}{\z@ }{%
    -3.5ex \@plus -1ex \@minus -.2ex}{%
    2.3ex \@plus .2ex}{%
    \normalfont \Large \sffamily\bfseries }}

\renewcommand{\sectionmark}[1]{%
  \markright{\thesection\ ---\ #1}}

\renewcommand{\subsection}{%
  \@startsection {subsection}{2}{\z@ }{%
    -3.25ex\@plus -1ex \@minus -.2ex}{%
    1.5ex \@plus .2ex}{%
    \normalfont \large \sffamily\bfseries }}

\renewcommand{\subsubsection}{%
  \@startsection {subsubsection}{3}{\z@ }{%
    -3.25ex\@plus -1ex \@minus -.2ex}{%
    1.5ex \@plus .2ex}{%
    \normalfont \normalsize\sffamily \bfseries }}

\renewcommand{\paragraph}{%
  \@startsection {paragraph}{4}{\z@ }{%
    3.25ex \@plus 1ex \@minus .2ex}{-1em}{%
    \normalfont \normalsize \sffamily\bfseries }}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                           Theorems,...
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Be compatible with \autoref (provided by hyperref)

\newtheorem{theorem}{\translate{Theorem}}[chapter]
\umons@AfterBeginDocument{% Do nor capitalize in French
  \def\theoremautorefname{\translate{umons@Theorem}}}

\newaliascnt{proposition}{theorem}
\newtheorem{proposition}[proposition]{\translate{Proposition}}
\aliascntresetthe{proposition}
\providecommand*{\propositionautorefname}{\translate{umons@Proposition}}

\newaliascnt{lemma}{theorem}
\newtheorem{lemma}[lemma]{\translate{Lemma}}
\aliascntresetthe{lemma}
\providecommand*{\lemmaautorefname}{\translate{umons@Lemma}}

\newaliascnt{corollary}{theorem}
\newtheorem{corollary}[corollary]{\translate{Corollary}}
\aliascntresetthe{corollary}
\providecommand*{\corollaryautorefname}{\translate{umons@Corollary}}

\theoremstyle{definition}

\newaliascnt{definition}{theorem}
\newtheorem{definition}[definition]{\translate{Definition}}
\aliascntresetthe{definition}
\providecommand*{\definitionautorefname}{\translate{umons@Definition}}

\theoremstyle{remark}

\newaliascnt{remark}{theorem}
\newtheorem{remark}[remark]{\translate{Remark}}
\aliascntresetthe{remark}
\providecommand*{\remarkautorefname}{\translate{umons@Remark}}


\umons@AfterBeginDocument{%
  \providecommand{\equationname}{\translate{umons@Equation}}%
  \def\equationautorefname~#1\null{%
    \equationname~(#1)\null}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                      M A T H   M A C R O S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% .......... Sets ..................................................
%
% mathbb symbols even outside math to allow alternatives for PDF
% titles.  Do not expand \umons@mathbb in the .toc so the \ifmmode is
% acted upon at the right place.
\newcommand{\mathbb@pdf}[1]{%
  \texorpdfstring{\protect\umons@mathbb{#1}}{#1}}
\newcommand{\umons@mathbb}[1]{%
  {\ifmmode \mathbb{#1}\else $\mathbb{#1}$\fi}}

\newcommand{\IN}{{\mathbb@pdf{N}}}
\newcommand{\IZ}{{\mathbb@pdf{Z}}}
\newcommand{\IQ}{{\mathbb@pdf{Q}}}
\newcommand{\IR}{{\mathbb@pdf{R}}}
\newcommand{\IC}{{\mathbb@pdf{C}}}
\newcommand{\IP}{{\mathbb@pdf{P}}}% proba

\newcommand{\C}{\texorpdfstring{\mathcal C}{C}}

\let\emptyset=\varnothing

% .......... Intervals, norms ..................................................
%
\newcommand{\intervalcc}[1]{\mathopen[#1\mathclose]}
\newcommand{\intervalco}[1]{\mathopen[#1\mathclose[}
\newcommand{\intervaloc}[1]{\mathopen]#1\mathclose]}
\newcommand{\intervaloo}[1]{\mathopen]#1\mathclose[}
\newcommand{\bigintervalcc}[1]{\bigl[#1\bigr]}
\newcommand{\bigintervalco}[1]{\bigl[#1\bigr[}
\newcommand{\bigintervaloc}[1]{\bigl]#1\bigr]}
\newcommand{\bigintervaloo}[1]{\bigl]#1\bigr[}
\newcommand{\Bigintervalcc}[1]{\Bigl[#1\bigr]}
\newcommand{\Bigintervalco}[1]{\Bigl[#1\Bigr[}
\newcommand{\Bigintervaloc}[1]{\Bigl]#1\Bigr]}
\newcommand{\Bigintervaloo}[1]{\Bigl]#1\Bigr[}
\newcommand{\biggintervalcc}[1]{\biggl[#1\biggr]}
\newcommand{\biggintervalco}[1]{\biggl[#1\biggr[}
\newcommand{\biggintervaloc}[1]{\biggl]#1\biggr]}
\newcommand{\biggintervaloo}[1]{\biggl]#1\biggr[}
\newcommand{\Biggintervalcc}[1]{\Biggl[#1\Biggr]}
\newcommand{\Biggintervalco}[1]{\Biggl[#1\Biggr[}
\newcommand{\Biggintervaloc}[1]{\Biggl]#1\Biggr]}
\newcommand{\Biggintervaloo}[1]{\Biggl]#1\Biggr[}

\newcommand{\abs}[1]{\mathopen| #1 \mathclose|}
\newcommand{\bigabs}[1]{\bigl| #1 \bigr|}
\newcommand{\Bigabs}[1]{\Bigl| #1 \Bigr|}
\newcommand{\biggabs}[1]{\biggl| #1 \biggr|}
\newcommand{\Biggabs}[1]{\Biggl| #1 \Biggr|}

\newcommand{\norm}[1]{\mathopen\| #1 \mathclose\|}
\newcommand{\bignorm}[1]{\bigl\| #1 \bigr\|}
\newcommand{\Bignorm}[1]{\Bigl\| #1 \Bigr\|}
\newcommand{\biggnorm}[1]{\biggl\| #1 \biggr\|}
\newcommand{\Biggnorm}[1]{\Biggl\| #1 \Biggr\|}


\newcommand{\intd}{\,\mathrm{d}}
\newcommand{\I}{{\textbf{\textit{i\/}}}}

\newcommand{\wto}{\rightharpoonup}                       % weak convergence
\newcommand{\subto}{\hookrightarrow}                     % arrow for inclusions
\newcommand{\id}{{\mathrm{id}}}                          % identity map
\newcommand{\dom}{\mathop{\operator@font dom}\nolimits}  % domain (initial set)
\newcommand{\codom}{\mathop{\operator@font codom}\nolimits}% co-domain (target)
\newcommand{\Dom}{\mathop{\operator@font Dom}\nolimits}  % domain of definition
\newcommand{\Ran}{\mathop{\operator@font Im}\nolimits}   % range
\newcommand{\Ker}{\mathop{\operator@font Ker}\nolimits}  % kernel of lin. map
\newcommand{\supp}{\mathop{\operator@font supp}\nolimits}% support of a function
\newcommand{\e}{{\operator@font e}}% exp

\renewcommand\limsup{\mathop{\overline{\operator@font lim}}}
\renewcommand\liminf{\mathop{\underline{\operator@font lim}}}
\newcommand\order{\mathop{\operator@font o}\nolimits}% small o of ...
\newcommand\Order{\mathop{\operator@font O}\nolimits}% big O of ...

\AtBeginDocument{%
  \ifx\upharpoonright\@undefined
    \newcommand\restrict{\mathclose|}% restriction, usage:
    \newcommand\bigrestrict{\bigr|}%   $f\restrict E$ or
    \newcommand\Bigrestrict{\Bigr|}%   $f\restrict_E$
  \else
    \newcommand\restrict{\mathclose\upharpoonright}%
    \newcommand\bigrestrict{\mathclose\upharpoonright}% (not delimiter)
    \newcommand\Bigrestrict{\Bigr\upharpoonright}%
  \fi    % \mathclose is necessary for the symbol to be close enough...!
  % 
  \@ifundefined{leqslant}{}{\let\le=\leqslant  \let\leq=\leqslant}%
  \@ifundefined{geqslant}{}{\let\ge=\geqslant  \let\geq=\geqslant}%
  \@ifundefined{nleqslant}{\newcommand\nle{\not\le}}{\let\nle=\nleqslant}%
  \@ifundefined{ngeqslant}{\newcommand\nge{\not\ge}}{\let\nge=\ngeqslant}%
}

% .......... Topology ..................................................
%
\newcommand\Nbd{\mathop{\operator@font Nbd}\nolimits}   % set of neighborhoods
\newcommand\Int{\mathop{\operator@font int}\nolimits}   % interior of a set
\newcommand\cl{\mathop{\operator@font cl}\nolimits}     % closure of a set
\newcommand\bd{\mathop{\operator@font b\kern -.5mm d}\nolimits} % boundary

% .......... Logic ..................................................
%
\newcommand{\limplies}{\Rightarrow}

% .......... Misc ...................................................
%
\let\phi=\varphi
\let\epsilon=\varepsilon
