module Metodos
    export calc_nx, analytic_solution, dif_finitas

    function calc_nx(delta_x, L)
        N = 0
        x = Float64[]

        for i in 0:delta_x:L
            N += 1
            if i != 0 && i != L
                append!(x, i)
            end
        end
        @show N

        return N, x
    end

    function analytic_solution(N, x::Array, fy::Function)        
        #y = zeros(Float64, N)
        y = zeros(Float64, N-2)
        # solucao analitica
        for i=1:N-2
            y[i] = fy(x[i])
        end

        return y
    end

    function dif_finitas(delta_x::Float64, pvc::Module, N = nothing)
        if N === nothing
            N = calc_nx(delta_x, pvc.L)[1]
        end

        A = zeros(Float64, N-2, N-2)
        B = fill(pvc.h_linha*(delta_x^2)*pvc.t_inf, N-2)
        # primeiro
        A[1, 1] = 2 + pvc.h_linha*delta_x^2
        A[1, 2] = -1
        B[1] += pvc.t_a

        # ultimo
        A[N-2, N-3] = -1
        A[N-2, N-2] = 2 + pvc.h_linha*delta_x^2
        B[N-2] += pvc.t_b
        
        for i in 2:N-3
            A[i, i-1] = -1
            A[i, i] = (2 + pvc.h_linha * delta_x^2)
            A[i, i+1] = -1

            B[i] = pvc.h_linha*(delta_x^2)*pvc.t_inf
        end

        result = A\B
        
        #insert!(result, 1, pvc.t_a)
        #insert!(result, N-1, pvc.t_b)

        return result
    end
end