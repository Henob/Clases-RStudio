
## TEST DE HIPOTESIS MEDIANTE RSTUDIO
## Docente: Rodrigo Del Rosso

# Limpiar la consola
rm(list = ls())

# Setear la ruta de trabajo
path = "C:/Users/rdelr/OneDrive - Facultad de Ciencias Econ�micas - Universidad de Buenos Aires/751 - 1C2019/RStudio/Clases/Clase 3 - 03-04/"
setwd(path)

# Comparaci�n de medias y varianzas - 2 grupos

# t.test(): comparaci�n de medias, prueba param�trica
# wilcox.test(): comparaci�n de medias, prueba no param�trica
# var.test(): comparaci�n de varianzas entre 2 muestras
# bartlett.test(): comparaci�n de varianzas entre 2 o m�s muestras

pre <- c(0.7, -1.6, -0.2, -1.2, -0.1, 3.4, 3.7, 0.8, 0.0, 2.0)

post <- c(1.9, 0.8, 1.1, 0.1, -0.1, 4.4, 5.5, 1.6, 4.6, 3.4)

# Comparaci�n de medias de datos emparejados (antes - despu�s)
t.test(pre, post, paired = TRUE)

# Comparaci�n de medias de datos emparejados (antes - despu�s)
wilcox.test(pre, post, paired = TRUE)

# Comparaci�n de medias de datos emparejados (antes - despu�s): 
# diferencia frente a 0
diff <- pre - post
hist(diff)

# Comparaci�n de medias de datos emparejados (antes - despu�s): t-test
t.test(diff, mu = 0)

# Comparaci�n de medias de datos emparejados (antes - despu�s): wilcoxon
wilcox.test(diff, mu = 0)

# Comparaci�n de medias entre 2 grupos independientes: datos
?sleep
data(sleep)
boxplot(extra ~ factor(group), data = sleep)

# Comparaci�n de medias entre 2 grupos independientes: igualdad de varianzas
bartlett.test(extra ~ factor(group), data = sleep) # igualdad de varianzas

# Comparaci�n de medias entre 2 grupos independientes: t-test asumiendo varianzas iguales
t.test(extra ~ factor(group), data = sleep, var.equal = TRUE)

# Comparaci�n de medias entre 2 grupos independientes: t-test sin asumir igualdad de varianzas
t.test(extra ~ factor(group), data = sleep)

# Comparaci�n de medias entre 2 grupos independientes: wilcoxon
wilcox.test(extra ~ factor(group), data = sleep)

# Diferencia de medias entre m�s de 2 grupos: ANOVA
# oneway.test(): an�lisis de la varianza de 1 v�a, param�trico
# kruskal.test(): an�lisis de la varianza de 1 v�a, no param�trico
# pairwise.t.test(): m�ltiples comparaciones (param�trico)
# pairwise.wilcox.test: m�ltiples comparaciones (no param�trico)
# aov(): an�lis de la varianza en general

# �ndice de pulsatilidad en la arteria cerebral 
# media seg�n exposici�n a cannabis

grupo <- c("control", "control", "control", "control", "control", "control", "activo", "activo", "activo", "activo", "activo", "activo", "ex", "ex", "ex", "ex", "ex", "ex")
index <- c(.9, .9, .9, .8, .8, NA, 1, 1, 1, 1, .9, NA, 1, 1, 1, 1, .9, .9)
pulsatilidad <- data.frame(grupo, index)
pulsatilidad

boxplot(index ~ grupo, data = pulsatilidad)

# ANOVA: igualdad de varianzas
bartlett.test(index ~ grupo, data = pulsatilidad)

# ANOVA: omnibus test
oneway.test(index ~ grupo, data = pulsatilidad)

# ANOVA: correcci�n para m�ltiples tests
pairwise.t.test(pulsatilidad$index, pulsatilidad$grupo)

# ANOVA: omnibus test con la funci�n aov()
aov.res <- aov(index ~ grupo, data = pulsatilidad) # ANOVA cl�sico
summary(aov.res)

# ANOVA: correcci�n para m�ltiples tests
TukeyHSD(aov.res)

# ANOVA: gr�fico para m�ltiples tests
plot(TukeyHSD(aov.res))

# ANOVA: prueba no param�trica
kruskal.test(index ~ grupo, data = pulsatilidad)

# ANOVA no param�trico: correcci�n para m�ltiples tests
pairwise.wilcox.test(index, grupo, data = pulsatilidad)

# Correlaci�n: funciones en R
# cor(): correlaciones param�tricas y no param�tricas
# cor.test(): test de significaci�n de la correlaci�n
# cov(): covarianza entre 2 variables

# Correlaci�n lineal: Anscombe 1
?anscombe # base de datos hist�rica en **R**
data(anscombe)

cor(anscombe$x1, anscombe$y1)
cor.test(anscombe$x1, anscombe$y1)
plot(anscombe$x1, anscombe$y1)
abline(lm(y1 ~ x1, data=anscombe))

# Correlaci�n lineal: Anscombe 2
cor.test(anscombe$x2, anscombe$y2)
plot(anscombe$x2, anscombe$y2)
abline(lm(y2 ~ x2, data=anscombe))

# Correlaci�n lineal: Anscombe 3
cor.test(anscombe$x3, anscombe$y3)
plot(anscombe$x3, anscombe$y3)
abline(lm(y3 ~ x3, data=anscombe))

# Correlaci�n lineal: Anscombe 4
cor.test(anscombe$x4, anscombe$y4)
plot(anscombe$x4, anscombe$y4)
abline(lm(y4 ~ x4, data=anscombe))

# Correlaci�n no implica causaci�n: nidos de cig�e�as y nacimientos
births <- c(4, 20, 60, 30, 7, 6, 14, 20, 18) # n�mero de nacimientos
nests <- c(2, 6, 8, 7, 0, 1, 2, 2, 3) # n�mero de nidos
plot(nests, births) # �hay asociaci�n?

cor.test(nests, births) # correlaci�n de Pearson por defecto
cor.test(nests, births, method = "spearman")
cor.test(nests, births, method = "kendall")
