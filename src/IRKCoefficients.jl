#
# IRKCoefficients.jl file:
#   PolInterp
#   MuCoefficients!
#   HCoefficients!
#   EstimateCoeffs!

function PolInterp(X::AbstractVector{ctype},
                   Y::AbstractMatrix{ctype},
                   Z::AbstractVector{ctype}) where {ctype}
    N = length(X)
    M = length(Z)
    K = size(Y, 1)
    if size(Y, 2) != N
        error("columns(Y) != length(X)")
    end
    pz = zeros(ctype, K, M)

    @inbounds begin for i in 1:N
        lag = 1.0
        for j in 1:N
            if (j != i)
                lag *= X[i] - X[j]
            end
        end
        lag = 1 / lag
        for m in 1:M
            liz = lag
            for j in 1:N
                if (j != i)
                    liz *= Z[m] - X[j]
                end
            end
            for k in 1:K
                pz[k, m] += Y[k, i] * liz
            end
        end
    end end
    return pz
end

function MuCoefficients!(mu, T::Type{<:CompiledFloats})
    mu[1, 1] = convert(T, 0.5)

    mu[2, 1] = convert(T, +1.0818949631055814971365081647359309e+00)
    mu[2, 2] = convert(T, 0.5)

    mu[3, 1] = convert(T, +9.5995729622205494766003095439844678e-01)
    mu[3, 2] = convert(T, +1.0869589243008327233290709646162480e+00)
    mu[3, 3] = convert(T, 0.5)

    mu[4, 1] = convert(T, +1.0247213458032003748680445816450829e+00)
    mu[4, 2] = convert(T, +9.5505887369737431186016905653386876e-01)
    mu[4, 3] = convert(T, +1.0880938387323083134422138713913203e+00)
    mu[4, 4] = convert(T, 0.5)

    mu[5, 1] = convert(T, +9.8302382676362890697311829123888390e-01)
    mu[5, 2] = convert(T, +1.0287597754747493109782305570410685e+00)
    mu[5, 3] = convert(T, +9.5383453518519996588326911440754302e-01)
    mu[5, 4] = convert(T, +1.0883471611098277842507073806008045e+00)
    mu[5, 5] = convert(T, 0.5)

    mu[6, 1] = convert(T, +1.0122259141132982060539425317219435e+00)
    mu[6, 2] = convert(T, +9.7998287236359129082628958290257329e-01)
    mu[6, 3] = convert(T, +1.0296038730649779374630125982121223e+00)
    mu[6, 4] = convert(T, +9.5383453518519996588326911440754302e-01)
    mu[6, 5] = convert(T, +1.0880938387323083134422138713913203e+00)
    mu[6, 6] = convert(T, 0.5)

    mu[7, 1] = convert(T, +9.9125143323080263118822334698608777e-01)
    mu[7, 2] = convert(T, +1.0140743558891669291459735166525994e+00)
    mu[7, 3] = convert(T, +9.7998287236359129082628958290257329e-01)
    mu[7, 4] = convert(T, +1.0287597754747493109782305570410685e+00)
    mu[7, 5] = convert(T, +9.5505887369737431186016905653386876e-01)
    mu[7, 6] = convert(T, +1.0869589243008327233290709646162480e+00)
    mu[7, 7] = convert(T, 0.5)

    mu[8, 1] = convert(T, +1.0054828082532158826793409353214951e+00)
    mu[8, 2] = convert(T, +9.9125143323080263118822334698608777e-01)
    mu[8, 3] = convert(T, +1.0122259141132982060539425317219435e+00)
    mu[8, 4] = convert(T, +9.8302382676362890697311829123888390e-01)
    mu[8, 5] = convert(T, +1.0247213458032003748680445816450829e+00)
    mu[8, 6] = convert(T, +9.5995729622205494766003095439844678e-01)
    mu[8, 7] = convert(T, +1.0818949631055814971365081647359309e+00)
    mu[8, 8] = convert(T, 0.5)

    s = 8
    @inbounds begin for i in 1:s
        for j in (i + 1):s
            mu[i, j] = 1 - mu[j, i]
        end
    end end
end

function MuCoefficients!(mu, T)

    #          println("Mu: NO CompiledFloats !!!")

    mu[1, 1] = parse(T, "0.5")

    mu[2, 1] = parse(T, "+1.0818949631055814971365081647359309e+00")
    mu[2, 2] = parse(T, "0.5")

    mu[3, 1] = parse(T, "+9.5995729622205494766003095439844678e-01")
    mu[3, 2] = parse(T, "+1.0869589243008327233290709646162480e+00")
    mu[3, 3] = parse(T, "0.5")

    mu[4, 1] = parse(T, "+1.0247213458032003748680445816450829e+00")
    mu[4, 2] = parse(T, "+9.5505887369737431186016905653386876e-01")
    mu[4, 3] = parse(T, "+1.0880938387323083134422138713913203e+00")
    mu[4, 4] = parse(T, "0.5")

    mu[5, 1] = parse(T, "+9.8302382676362890697311829123888390e-01")
    mu[5, 2] = parse(T, "+1.0287597754747493109782305570410685e+00")
    mu[5, 3] = parse(T, "+9.5383453518519996588326911440754302e-01")
    mu[5, 4] = parse(T, "+1.0883471611098277842507073806008045e+00")
    mu[5, 5] = parse(T, "0.5")

    mu[6, 1] = parse(T, "+1.0122259141132982060539425317219435e+00")
    mu[6, 2] = parse(T, "+9.7998287236359129082628958290257329e-01")
    mu[6, 3] = parse(T, "+1.0296038730649779374630125982121223e+00")
    mu[6, 4] = parse(T, "+9.5383453518519996588326911440754302e-01")
    mu[6, 5] = parse(T, "+1.0880938387323083134422138713913203e+00")
    mu[6, 6] = parse(T, "0.5")

    mu[7, 1] = parse(T, "+9.9125143323080263118822334698608777e-01")
    mu[7, 2] = parse(T, "+1.0140743558891669291459735166525994e+00")
    mu[7, 3] = parse(T, "+9.7998287236359129082628958290257329e-01")
    mu[7, 4] = parse(T, "+1.0287597754747493109782305570410685e+00")
    mu[7, 5] = parse(T, "+9.5505887369737431186016905653386876e-01")
    mu[7, 6] = parse(T, "+1.0869589243008327233290709646162480e+00")
    mu[7, 7] = parse(T, "0.5")

    mu[8, 1] = parse(T, "+1.0054828082532158826793409353214951e+00")
    mu[8, 2] = parse(T, "+9.9125143323080263118822334698608777e-01")
    mu[8, 3] = parse(T, "+1.0122259141132982060539425317219435e+00")
    mu[8, 4] = parse(T, "+9.8302382676362890697311829123888390e-01")
    mu[8, 5] = parse(T, "+1.0247213458032003748680445816450829e+00")
    mu[8, 6] = parse(T, "+9.5995729622205494766003095439844678e-01")
    mu[8, 7] = parse(T, "+1.0818949631055814971365081647359309e+00")
    mu[8, 8] = parse(T, "0.5")

    s = 8
    @inbounds begin for i in 1:s
        for j in (i + 1):s
            mu[i, j] = 1 - mu[j, i]
        end
    end end
end

function HCoefficients!(mu, hc, hb, nu, h, hprev, T::Type{<:CompiledFloats})
    hb .= convert.(T,
                   [
                       +5.0614268145188129576265677154981094e-02,
                       +1.1119051722668723527217799721312045e-01,
                       +1.5685332293894364366898110099330067e-01,
                       +1.8134189168918099148257522463859781e-01,
                       +1.8134189168918099148257522463859781e-01,
                       +1.5685332293894364366898110099330067e-01,
                       +1.1119051722668723527217799721312045e-01,
                       +5.0614268145188129576265677154981094e-02,
                   ])

    hc .= convert.(T,
                   [
                       +1.9855071751231884158219565715263505e-02,
                       +1.0166676129318663020422303176208480e-01,
                       +2.3723379504183550709113047540537686e-01,
                       +4.0828267875217509753026192881990801e-01,
                       +5.9171732124782490246973807118009203e-01,
                       +7.6276620495816449290886952459462321e-01,
                       +8.9833323870681336979577696823791522e-01,
                       +9.8014492824876811584178043428473653e-01,
                   ])

    s = length(hb)

    """ Interpolate coefficients """

    if (hprev == 0.0)
        nu .= zeros(T, s, s)
    else
        lambda = h / hprev
        X = vcat(-hc[end:-1:1], [0])
        Y = hcat(mu, zeros(T, s))
        Z = lambda * hc
        nu .= -(PolInterp(X, Y, Z))'
    end

    """ hb """

    hb .= hb * h
    hb1 = (h - sum(hb[2:(end - 1)])) / 2
    hb[1] = hb1
    hb[end] = hb1

    hc .= hc * h

    return
end

function HCoefficients!(mu, hc, hb, nu, h, hprev, T)

    #          println("HCoefficients: NO Compiled")

    hb .= [
        parse(T, "+5.0614268145188129576265677154981094e-02"),
        parse(T, "+1.1119051722668723527217799721312045e-01"),
        parse(T, "+1.5685332293894364366898110099330067e-01"),
        parse(T, "+1.8134189168918099148257522463859781e-01"),
        parse(T, "+1.8134189168918099148257522463859781e-01"),
        parse(T, "+1.5685332293894364366898110099330067e-01"),
        parse(T, "+1.1119051722668723527217799721312045e-01"),
        parse(T, "+5.0614268145188129576265677154981094e-02"),
    ]

    hc .= [
        parse(T, "+1.9855071751231884158219565715263505e-02"),
        parse(T, "+1.0166676129318663020422303176208480e-01"),
        parse(T, "+2.3723379504183550709113047540537686e-01"),
        parse(T, "+4.0828267875217509753026192881990801e-01"),
        parse(T, "+5.9171732124782490246973807118009203e-01"),
        parse(T, "+7.6276620495816449290886952459462321e-01"),
        parse(T, "+8.9833323870681336979577696823791522e-01"),
        parse(T, "+9.8014492824876811584178043428473653e-01"),
    ]

    s = length(hb)

    """ Interpolate coefficients """

    if (hprev == 0.0)
        nu .= zeros(T, s, s)
    else
        lambda = h / hprev
        X = vcat(-hc[end:-1:1], [0])
        Y = hcat(mu, zeros(T, s))
        Z = lambda * hc
        nu .= -(PolInterp(X, Y, Z))'
    end

    """ hb """

    hb .= hb * h
    hb1 = (h - sum(hb[2:(end - 1)])) / 2
    hb[1] = hb1
    hb[end] = hb1

    hc .= hc * h

    return
end

function EstimateCoeffs!(alpha, T::Type{<:CompiledFloats})
    c = convert.(T,
                 [
                     +1.9855071751231884158219565715263505e-02,
                     +1.0166676129318663020422303176208480e-01,
                     +2.3723379504183550709113047540537686e-01,
                     +4.0828267875217509753026192881990801e-01,
                     +5.9171732124782490246973807118009203e-01,
                     +7.6276620495816449290886952459462321e-01,
                     +8.9833323870681336979577696823791522e-01,
                     +9.8014492824876811584178043428473653e-01,
                 ])

    s = length(c)

    B = vcat(zeros(T, s - 1), 1)
    M = [(c[i] - 1 / 2)^(k - 1) for i in 1:s, k in 1:s]'
    alpha .= 1000 * M \ B

    return
end

function EstimateCoeffs!(alpha, T)

    #    println("Estimate2: NO Compiled")

    c = [
        parse(T, "+1.9855071751231884158219565715263505e-02"),
        parse(T, "+1.0166676129318663020422303176208480e-01"),
        parse(T, "+2.3723379504183550709113047540537686e-01"),
        parse(T, "+4.0828267875217509753026192881990801e-01"),
        parse(T, "+5.9171732124782490246973807118009203e-01"),
        parse(T, "+7.6276620495816449290886952459462321e-01"),
        parse(T, "+8.9833323870681336979577696823791522e-01"),
        parse(T, "+9.8014492824876811584178043428473653e-01"),
    ]

    s = length(c)

    B = vcat(zeros(T, s - 1), 1)
    M = [(c[i] - 1 / 2)^(k - 1) for i in 1:s, k in 1:s]'
    alpha .= 1000 * M \ B

    return
end
