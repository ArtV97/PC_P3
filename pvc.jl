# Equacao
module PVC
    export fy, h_linha, h, r, k, t_a, t_b, t_inf, L

    # dados do problema
    h_linha = 0.05 # m^-2
    h = 1 # J/m^2*Ks
    r = 0.2 # m
    k = 200 # J/(mks)
    t_inf = 200 # kelvin
    t_a = 243 # kelvin
    t_b = 400 # kelvin
    L = 10 # m

    # Solucao analitica
    function fy(x)
        lambda = sqrt(h_linha)

        A = ((t_a - t_inf)*MathConstants.e^(-lambda*L) - (t_b - t_inf)) / (MathConstants.e^(-lambda*L) - MathConstants.e^(lambda*L))
        B = ((t_b - t_inf) - (t_a - t_inf)*MathConstants.e^(lambda*L)) / (MathConstants.e^(-lambda*L) - MathConstants.e^(lambda*L))

        y = t_inf + A * MathConstants.e^(lambda*x) + B * MathConstants.e^(-lambda*x)
        return y
    end
end
