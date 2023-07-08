function output = exec_serialdil(params)
%     [endb,endNr,bstore,Nrstore] = ...
%         serialdilMADAPT(params.rho0,10.^params.log10c0,params.alpha,...
%                         params.P,params.m,params.p,0,params.b0',params.errtype,params.K);
%     output.rho=bstore;
%     output.NutIntegrals=Nrstore';
%     output.ShannonS=calc_entropy_nats(output.rho);

    output = serialdil_odesolver(params, 0);
    [corr,errcorr,correction] = extract_corr(output.ShannonS', 0,0);
    output.corrlen=corr;
    output.corrlen_err=errcorr;
    output.corrlen_correction=correction;
